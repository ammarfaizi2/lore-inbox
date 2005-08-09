Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbVHIH17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbVHIH17 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 03:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbVHIH17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 03:27:59 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:11236 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932403AbVHIH16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 03:27:58 -0400
Subject: Re: Adaptec AHA-2940U2W "Data Parity Error Dectected" messages
From: Lee Revell <rlrevell@joe-job.com>
To: Daniel Pittman <daniel@rimspace.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <878xzbr2zw.fsf@rimspace.net>
References: <878xzbr2zw.fsf@rimspace.net>
Content-Type: text/plain
Date: Tue, 09 Aug 2005 03:27:54 -0400
Message-Id: <1123572475.27813.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-09 at 17:19 +1000, Daniel Pittman wrote:
> I recently installed a SCSI tape drive and Adaptec AHA-2940U2W SCSI
> controller into my server to run backups.
> 
> Since then, the driver issues these warnings on a semi-regular basis
> while the drive is busy:
> 
> Aug  9 17:00:26 anu kernel: scsi0: Data Parity Error Detected during address or write data phase
> Aug  9 17:00:26 anu kernel: scsi0: PCI error Interrupt at seqaddr = 0x8

Make sure the hardware is all installed correctly.  Check that the card
is fully seated, or try it in another PCI slot.  Also check your cabling
and termination.

Lee

