Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267441AbRGTWPn>; Fri, 20 Jul 2001 18:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267431AbRGTWPd>; Fri, 20 Jul 2001 18:15:33 -0400
Received: from w090.z064003079.san-ca.dsl.cnc.net ([64.3.79.90]:28148 "HELO
	mail.land-5.com") by vger.kernel.org with SMTP id <S267441AbRGTWPQ>;
	Fri, 20 Jul 2001 18:15:16 -0400
Date: Fri, 20 Jul 2001 15:15:32 -0700 (PDT)
From: jsack <jsack@land-5.com>
To: Roland Fehrenbacher <r.fehrenbacher@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: qlogicfc driver
In-Reply-To: <01072023015700.01297@zap>
Message-ID: <Pine.LNX.4.10.10107201512250.1114-100000@jgs.land-5.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Fri, 20 Jul 2001, Roland Fehrenbacher wrote:

> > While the controller itself sees all the 3 drives
> > when booting up, under Linux I am only able to see the LUN 0 drives.
> 
> Update to my previous post:
> 
> The command 
> echo "scsi add-single-device 0 0 0 1" > /proc/scsi/scsi
> makes the LUN 1 device appear, so it seems the problem is with the SCSI 
> scanning code.
> 


is "probe all luns" configured in your kernel? 
 (.config: CONFIG_SCSI_MULTI_LUN=y)

..jim

