Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267440AbRGTV6C>; Fri, 20 Jul 2001 17:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267441AbRGTV5w>; Fri, 20 Jul 2001 17:57:52 -0400
Received: from mailgate3.cinetic.de ([212.227.116.80]:58568 "EHLO
	mailgate3.cinetic.de") by vger.kernel.org with ESMTP
	id <S267440AbRGTV5p>; Fri, 20 Jul 2001 17:57:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roland Fehrenbacher <r.fehrenbacher@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: qlogicfc driver
Date: Fri, 20 Jul 2001 23:01:57 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01072023015700.01297@zap>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> While the controller itself sees all the 3 drives
> when booting up, under Linux I am only able to see the LUN 0 drives.

Update to my previous post:

The command 
echo "scsi add-single-device 0 0 0 1" > /proc/scsi/scsi
makes the LUN 1 device appear, so it seems the problem is with the SCSI 
scanning code.

Roland
