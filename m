Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270452AbTHDAmf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 20:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270863AbTHDAmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 20:42:35 -0400
Received: from waste.org ([209.173.204.2]:5270 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S270452AbTHDAme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 20:42:34 -0400
Date: Sun, 3 Aug 2003 19:42:27 -0500
From: Matt Mackall <mpm@selenic.com>
To: Sander van Malssen <svm@kozmix.org>, Andrew Morton <akpm@osdl.org>,
       yoh@onerussian.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-bk3 phantom I/O errors
Message-ID: <20030804004227.GZ22824@waste.org>
References: <20030729153114.GA30071@washoe.rutgers.edu> <20030729135025.335de3a0.akpm@osdl.org> <20030730170432.GA692@kozmix.org> <20030730120002.29c13b0c.akpm@osdl.org> <20030730191115.GA733@kozmix.org> <20030803091007.GA885@kozmix.org> <20030803021727.3b54cd17.akpm@osdl.org> <20030803094634.GA430@kozmix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030803094634.GA430@kozmix.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 03, 2003 at 11:46:34AM +0200, Sander van Malssen wrote:
> On Sunday, 03 August 2003 at 02:17:27 -0700, Andrew Morton wrote:
> 
> > Sander van Malssen <svm@kozmix.org> wrote:
> > >
> > > Well, that's funny. If I run a pristine test2-mm3-1 kernel I don't get
> > >  those "Buffer I/O error on device ..." kernel messages anymore, but I do
> > >  get the actual I/O error itself.
> > 
> > The readahead problem got itself fixed.  You are seeing something
> > unrelated.
> > 
> > Please send a lot more details.
> 
> Alas no interesting kernel messages to show. FS is an ext3 on an IDE
> disk, no initrd.
> 
> The problem is easily reproduced thusly:
> 
> root@ava:~ # cat /var/log/kozmix/brooksie.log > /dev/null
> cat: /var/log/kozmix/brooksie.log: Input/output error
 
> Linux version 2.6.0-test2-mm3 (svm@ava.kozmix.org) (gcc version 3.2.2) #4 Sun Aug 3 11:29:19 CEST 2003

Sure you've got mm3-1? Andrew didn't bump the EXTRAVERSION.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
