Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279277AbRLLPip>; Wed, 12 Dec 2001 10:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280002AbRLLPif>; Wed, 12 Dec 2001 10:38:35 -0500
Received: from zeus.hjc.edu.sg ([203.127.28.34]:42888 "HELO zeus.hjc.edu.sg")
	by vger.kernel.org with SMTP id <S279277AbRLLPia>;
	Wed, 12 Dec 2001 10:38:30 -0500
To: Matt_Domsch@Dell.com
Subject: RE: AACRAID & Kernel-2.4.17-pre8
Message-ID: <1008171503.3c1779efbccbc@home.hjc.edu.sg>
Date: Wed, 12 Dec 2001 23:38:23 +0800 (SGT)
From: Chen Shiyuan <csy@hjc.edu.sg>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <71714C04806CD5119352009027289217022C40B9@ausxmrr502.us.dell.com>
In-Reply-To: <71714C04806CD5119352009027289217022C40B9@ausxmrr502.us.dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Hwa Chong Junior College Mail System (CMS)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

Many thanks for your assistance. The tons of messages no longer appear.

On Wed, 12 Dec 2001 09:04:12 -0600, Matt_Domsch@Dell.com wrote :

> > Does anyone know how to get rid of these messages
> 
> At the top of linux/drivers/scsi/aacraid/aacraid.h:
> #define dprintk(x)  printk x
> 
> Change that to be:
> #define dprintk(x)
> 
> Thanks,
> Matt
> 
> --
> Matt Domsch
> Sr. Software Engineer
> Dell Linux Solutions
> www.dell.com/linux
> #1 US Linux Server provider with 24% (IDC Sept 2001)
> #2 Worldwide Linux Server provider with 17% (IDC Sept 2001)
> #3 Unix provider with 18% in the US (Dataquest)!
