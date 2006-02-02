Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423024AbWBBGvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423024AbWBBGvO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 01:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423029AbWBBGvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 01:51:14 -0500
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:16621 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S1423024AbWBBGvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 01:51:14 -0500
Subject: Re: root=LABEL= problem [Was: Re: Linux Issue]
From: Arjan van de Ven <arjan@infradead.org>
To: Jiri Slaby <xslaby@fi.muni.cz>
Cc: kavitha s <wellspringkavitha@yahoo.co.in>, linux-kernel@vger.kernel.org
In-Reply-To: <20060201114845.E41F222AF24@anxur.fi.muni.cz>
References: <20060201114845.E41F222AF24@anxur.fi.muni.cz>
Content-Type: text/plain
Date: Thu, 02 Feb 2006 07:51:07 +0100
Message-Id: <1138863068.3270.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-01 at 12:48 +0100, Jiri Slaby wrote:
> >Hi,
> >    I have some problem while booting inside linux,so
> >tried to boot in single user mode for some changes in
> >/etc/grub.conf.But iam not able to boot in single user
> >mode.It is giving error message as
> >
> > ds: no socket drivers loaded!
> > VFS: Cannot open root device "LABEL=/" or 00:00
> change root=LABEL=/ to root=/dev/XXX. Vanilla doesn't support this...

ehhh??
sure it does.

this is not a kernel feature, but an initrd feature, independent on
which kernel is used (there never was and is not a patch for this in any
distro kernel I know about)


