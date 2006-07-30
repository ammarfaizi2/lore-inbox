Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWG3JKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWG3JKU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 05:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbWG3JKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 05:10:20 -0400
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:17056 "HELO
	briare1.heliogroup.fr") by vger.kernel.org with SMTP
	id S932080AbWG3JKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 05:10:19 -0400
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.18-rc3
Date: Sun, 30 Jul 2006 12:56:04 GMT
Message-ID: <06ATVXG12@briare1.heliogroup.fr>
X-Mailer: Pliant 96
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>
> Which distribution and glibc version are you using?

This is FullPliant, so not really a Unix like Linux distribution
http://fullpliant.org/

'glibc' is not really used by Pliant which is mostly self contained (issues
direct kernel calls)
but Pliant has to link to 'libld' because Linux is a strange operating system
where loading a DLL is not a kernel function, and it seems that 'libdl' requires
'libc'
As a result, FullPliant picks a fiew executables and DLLs from some Debian
packages at install time.
Also I keep track in a database of each Debian package I select at install time,
it may well not be reliable because the database is not updated if I later 
upgrade the system remotely.
The Debian package number I have in the database for glibc is 2.3.2.ds1-18

PS: I made a typo in my previous message: the kernel I have not tested is
2.6.18-rc1, not 2.6.17-rc1

