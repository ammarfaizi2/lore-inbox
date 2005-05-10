Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVEJK2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVEJK2F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 06:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVEJK2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 06:28:05 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:41600 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261597AbVEJK2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 06:28:02 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 1/6] uml: remove elf.h [ compile-fix, for 2.6.12 ]
Date: Tue, 10 May 2005 12:16:58 +0200
User-Agent: KMail/1.8
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <20050509224509.0C105416E4@zion> <20050509183401.28082cbc.akpm@osdl.org>
In-Reply-To: <20050509183401.28082cbc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505101216.59293.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 May 2005 03:34, Andrew Morton wrote:
> blaisorblade@yahoo.it wrote:
> > Actually remove elf.h in the tree. The previous patch, due to a quilt
> > bug/misuse, left it in the tree as a 0-length file, preventing the build
> > to see it as missing and to generate a symlink in its place.

Ok, I was confused by the fact that with patch-scripts, which you use, it 
works, and thought it was patch to make it work.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

