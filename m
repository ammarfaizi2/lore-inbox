Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262631AbVENAA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262631AbVENAA6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 20:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbVENAA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 20:00:58 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:52662 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262625AbVENAAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 20:00:32 -0400
In-Reply-To: <428482A1.5090107@vlnb.net>
To: Vladislav Bolkhovitin <vst@vlnb.net>
Cc: David Hollis <dhollis@davehollis.com>, dmitry_yus@yahoo.com,
       FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
       Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       iscsitarget-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Sander <sander@humilis.net>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>
MIME-Version: 1.0
Subject: Re: SCSI/ISCSI, hardware/software
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF7E993A36.0D88FEC0-ON88257000.0082C701-88257000.0083CAAD@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Fri, 13 May 2005 16:58:59 -0700
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V70_04122005|April 12, 2005) at
 05/13/2005 20:00:11,
	Serialize complete at 05/13/2005 20:00:11
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Such iSCSI card from a user point of view as well as for system running 
>on a computer with it is just another SCSI card, not matter which 
>transport it uses and how much software it runs onboard, so for they it 
>doesn't differ from FC or parallel SCSI one, which I think you would not 
>call a software unit.  As usually, you only need appropriate driver for 
>_SCSI_ subsystem.

The point I'd like to make is that _I_ would not call it a software unit 
or a hardware unit, because I don't think in most contexts (including that 
of this thread), it makes any difference which technology is used in the 
implementation.  What _does_ matter is 1) this card comes preassembled.  I 
don't have to find and load independently produced software onto it, or 
worry about interoperability.  2) It's below the Linux kernel, which means 
I won't need to mess with Linux applications or kernels except to load a 
low level SCSI driver.  It also means it doesn't place any load on my main 
CPU and probably goes faster than something implemented in or above my 
Linux kernel would.

And there's the separate point that it would be a misnomer to say that 
this card is an ISCSI initiator (it's only part of one); so even if the 
card itself can be called hardware, that still doesn't mean you can say 
you have a hardware ISCSI initiator.  Same is true of a parallel SCSI host 
adapter card.

--
Bryan Henderson                          IBM Almaden Research Center
San Jose CA                              Filesystems
