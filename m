Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282164AbRK1Phq>; Wed, 28 Nov 2001 10:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281560AbRK1Phg>; Wed, 28 Nov 2001 10:37:36 -0500
Received: from www.automatix.de ([212.4.161.35]:21520 "EHLO mail.automatix.de")
	by vger.kernel.org with ESMTP id <S282164AbRK1PhV>;
	Wed, 28 Nov 2001 10:37:21 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Juergen Sauer <jojo@automatix.de>
Organization: AutomatiX GmbH
To: Pascal Haakmat <a.haakmat@chello.nl>, linux-kernel@vger.kernel.org
Subject: Re: XFS Oopses with 2.4.5 and 2.4.14?
Date: Wed, 28 Nov 2001 16:29:07 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <000701c177e6$7317af40$ea9133d5@groni1.gr.nl.home.com> <20011128155716.A7302@awacs.dhs.org>
In-Reply-To: <20011128155716.A7302@awacs.dhs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <E1696e6-0004nn-00@s.automatix.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 28. November 2001 15:57 schrieb Pascal Haakmat:
> Given the following Oopses, is it wise to continue running the XFS
> filesystem, or might there be some other underlying problem that is
> causing these Oopses?
>
> Kernel 2.4.5 + XFS 1.0.1:
>
> Nov 25 07:28:23 awacs kernel: Unable to handle kernel paging request at
[...]

I had these problems in the past with a inconsitent XFS Filesystem, I'd 
recommend to run xfs_repair on your XFS filesystems, using a external 
Rescue CD - bootdisk/bootCD. If you have none handy, drop me a mail.

The fs-troubles on my server was arising using a Highend-Caching 
controller (ICP-Vortex), and not flushing the cache before power down.
After several power downs the XFS had headaches, and I had such 
kernel-oops.

mfG
	Jojo

-- 
Jürgen Sauer - AutomatiX GmbH, +49-4209-4699, jojo@automatix.de **
** Das Linux Systemhaus - Service - Support - Server - Lösungen **
http://www.automatix.de to Mail me: remove: -not-for-spawm-     **
