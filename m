Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316322AbSGLNSZ>; Fri, 12 Jul 2002 09:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316364AbSGLNSY>; Fri, 12 Jul 2002 09:18:24 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28164 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316322AbSGLNSY>; Fri, 12 Jul 2002 09:18:24 -0400
Subject: Re: IDE/ATAPI in 2.5
To: hpa@zytor.com (H. Peter Anvin)
Date: Fri, 12 Jul 2002 14:15:35 +0100 (BST)
Cc: andre@linux-ide.org (Andre Hedrick), andersen@codepoet.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <3D2E6506.7080006@zytor.com> from "H. Peter Anvin" at Jul 11, 2002 10:11:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17T0Gl-0002wk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm talking specifically about ATAPI devices here.  As we have already 
> covered, not all ATA devices are ATAPI, but unless I'm completely off 
> the wall, ATAPI is SCSI over IDE, and should be able to be driven as 
> such.  The lack of access to that interface using the established 
> interface mechanisms just bites.

If you load ide-scsi they are run as ATAPI, whats the problem ? Just don't
do that for very old ide cdroms or for some ide floppies
