Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbVC1Oxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbVC1Oxn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 09:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVC1Oxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 09:53:43 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:24773 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261824AbVC1Oxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 09:53:37 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Willy TARREAU <willy@w.ods.org>
Cc: David Dyck <david.dyck@fluke.com>, Adrian Bunk <bunk@stusta.de>,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: upgrading modutils may have fixed: unresolved symbols still in 2.4.30-rc2 (usbserial needs symbol tty_ldisc_ref and tty_ldisc_deref which are EXPORT_SYMBOL_GPL) 
In-reply-to: Your message of "Mon, 28 Mar 2005 13:37:31 +0200."
             <20050328113731.GA2131@pcw.home.local> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 29 Mar 2005 00:53:19 +1000
Message-ID: <10606.1112021599@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2005 13:37:31 +0200, 
Willy TARREAU <willy@w.ods.org> wrote:
>On Mon, Mar 28, 2005 at 09:00:59PM +1000, Keith Owens wrote:
>> You need modutils >= 2.4.14 to use the combination of
>> CONFIG_MODVERSIONS with EXPORT_SYMBOL_GPL() on 2.4 kernels.
>
>Thanks for the precision Keith.
>
>So the following seems appropriate ?
>
>--- ./Documentation/Changes.old	Sat Mar 26 07:42:46 2005
>+++ ./Documentation/Changes	Mon Mar 28 13:35:06 2005
>@@ -52,7 +52,7 @@
> o  Gnu make               3.77                    # make --version
> o  binutils               2.9.1.0.25              # ld -v
> o  util-linux             2.10o                   # fdformat --version
>-o  modutils               2.4.10                   # insmod -V
>+o  modutils               2.4.14                   # insmod -V
> o  e2fsprogs              1.25                    # tune2fs
> o  jfsutils               1.0.12                  # fsck.jfs -V
> o  reiserfsprogs          3.6.3                   # reiserfsck -V 2>&1|grep reiserfsprogs
>

Ack.

