Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVCKRZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVCKRZA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 12:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVCKRZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 12:25:00 -0500
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:64699 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261216AbVCKRY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 12:24:58 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [PATCH 4/9] UML - Export gcov symbol based on gcc version
Date: Fri, 11 Mar 2005 18:00:56 +0100
User-Agent: KMail/1.7.2
Cc: Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Jeff Dike <jdike@addtoit.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <200503100216.j2A2G2DN015232@ccure.user-mode-linux.org> <20050310225340.GD3205@stusta.de> <Pine.LNX.4.58.0503101516190.2530@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503101516190.2530@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503111800.56423.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 March 2005 00:21, Linus Torvalds wrote:
> On Thu, 10 Mar 2005, Adrian Bunk wrote:
> > This patch is still wrong.
>
> Can't we just fix it by havign an alias for both names?
No, because the patch is wrong. It should export both symbols in the second 
case.
> It seems stupid to 
> jump through hoops and worry about compiler versions, when afaik we could
> just do something like
>
>  extern xxxx(...) __attribute__((alias("yyyy")));
>
> instead. Exact details left to the reader who knows more about all the
> magic gcc/linker things..
>
>   Linus

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


