Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280531AbRLLPFS>; Wed, 12 Dec 2001 10:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280588AbRLLPE6>; Wed, 12 Dec 2001 10:04:58 -0500
Received: from ausxc07.us.dell.com ([143.166.227.166]:26774 "EHLO
	ausxc07.us.dell.com") by vger.kernel.org with ESMTP
	id <S280531AbRLLPEt>; Wed, 12 Dec 2001 10:04:49 -0500
Message-ID: <71714C04806CD5119352009027289217022C40B9@ausxmrr502.us.dell.com>
From: Matt_Domsch@Dell.com
To: csy@hjc.edu.sg, linux-kernel@vger.kernel.org
Subject: RE: AACRAID & Kernel-2.4.17-pre8
Date: Wed, 12 Dec 2001 09:04:12 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does anyone know how to get rid of these messages

At the top of linux/drivers/scsi/aacraid/aacraid.h:
#define dprintk(x)  printk x

Change that to be:
#define dprintk(x)

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions
www.dell.com/linux
#1 US Linux Server provider with 24% (IDC Sept 2001)
#2 Worldwide Linux Server provider with 17% (IDC Sept 2001)
#3 Unix provider with 18% in the US (Dataquest)!
