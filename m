Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285720AbSBZW4k>; Tue, 26 Feb 2002 17:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285850AbSBZW4h>; Tue, 26 Feb 2002 17:56:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29446 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285720AbSBZWzs>; Tue, 26 Feb 2002 17:55:48 -0500
Subject: Re: tmpfs file permissions in 2.4.19-pre1-ac1
To: jonathan@daria.co.uk (Jonathan Hudson)
Date: Tue, 26 Feb 2002 23:10:35 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2d40.3c7c1089.64a4b@trespassersw.daria.co.uk> from "Jonathan Hudson" at Feb 26, 2002 10:47:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16fqjz-0002Pl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've noticed some strangeness with (at least) file permissions on a
> tmpfs file system. I can't change the permissions of files I own (or,
> as root, of any file) on the tmpfs.

That sounds quite believable - I've probably broken the attribute notifier
I use so that I can monitor file size changes. I'll take a look
