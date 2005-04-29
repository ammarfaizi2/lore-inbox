Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbVD1UaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbVD1UaQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 16:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVD1UaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 16:30:16 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:49274 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262157AbVD1UaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 16:30:11 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [patch 1/7] uml: fix syscall table by including $(SUBARCH)'s one, for i386
Date: Fri, 29 Apr 2005 22:31:18 +0200
User-Agent: KMail/1.8
Cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org, jdike@addtoit.com,
       bstroesser@fujitsu-siemens.com, linux-kernel@vger.kernel.org
References: <20050424181909.81B8F33AED@zion> <20050428181053.GQ23013@shell0.pdx.osdl.net>
In-Reply-To: <20050428181053.GQ23013@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504292231.18763.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 April 2005 20:10, Chris Wright wrote:
> * blaisorblade@yahoo.it (blaisorblade@yahoo.it) wrote:
> > Split the i386 entry.S files into entry.S and syscall_table.S which
> > is included in the previous one (so actually there is no difference
> > between them) and use the syscall_table.S in the UML build, instead of
> > tracking by hand the syscall table changes (which is inherently
> > error-prone).
>
> Xen can use this as well (it was on my todo list).
Yes, I had this idea too. So I guess this will be promptly merged, right?

-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

