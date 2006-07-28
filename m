Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161278AbWG1UO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161278AbWG1UO6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 16:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161267AbWG1UO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 16:14:58 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:6284 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161278AbWG1UO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 16:14:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:x-mimeole:thread-index;
        b=MeO49DOUyJi71Z6Rv9wJTfkStHEy2L7F6i5hVaZ6Ax5/US0/My2jJW73tN7iTGW4Fz44Y0qLTX1GSZtJq6PGjsqMyTOvMKg72uJ7SdENhGxfnSuHis/gUPymCWxLXS8x6MKkam4OFiViHBdfFxY62towmtb62PzVDT+U5woWS6w=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'David Masover'" <ninja@slaphack.com>,
       "'Hans Reiser'" <reiser@namesys.com>
Cc: "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Horst H. von Brand'" <vonbrand@inf.utfsm.cl>,
       "'Jeff Garzik'" <jeff@garzik.org>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Theodore Tso'" <tytso@mit.edu>,
       "'LKML'" <linux-kernel@vger.kernel.org>,
       "'ReiserFS List'" <reiserfs-list@namesys.com>
Subject: RE: metadata plugins (was Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion)
Date: Fri, 28 Jul 2006 13:14:54 -0700
Message-ID: <005e01c6b282$7eb372e0$493d010a@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <44CA6905.4050002@slaphack.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Thread-Index: AcayfoHNprYn8OPmQLCQ7golCa7MZQAAx9iQ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Doesn't have to be in fstab, I hope, but think of it this 
> way:  ext3 uses JBD for its journaling.  As I understand it, 
> any other filesystem can also use JBD, and ext3 is mostly ext2 + JDB.

The fact that no other major journaling filesystems use JBD except EXT3 might make this idea less appealing..

You can also say "other filesystems CAN use plugin". But who actually want to use it now? Even if there are people that want to use
it, they should help doing the work.

I remember someone said something along the lines of "Linux is evolution, not revolution". To me it seems unreasonable to put all
the "revolutionary" VFS burden upon reiserfs team. It's not practical.

Hua

