Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314321AbSD0SEl>; Sat, 27 Apr 2002 14:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314327AbSD0SEk>; Sat, 27 Apr 2002 14:04:40 -0400
Received: from gear.torque.net ([204.138.244.1]:49422 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S314321AbSD0SEj>;
	Sat, 27 Apr 2002 14:04:39 -0400
Message-ID: <3CCAE730.71E856E@torque.net>
Date: Sat, 27 Apr 2002 14:00:16 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.9-dj1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org,
        James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: linux-2.5.x-dj and SCSI error handling.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> > The recent patch from Christoph Hellwig which kills off
> > the last remaining remnants of the old style SCSI error handling.
> > ...
>
> Is the new scsi-eh generally regarded as a good thing?

Andries,
If it isn't a good thing at the moment, James Bottomley
intends to make it a good thing shortly.

The new scsi_eh is a better design, and in 2.5 the scsi
mid level only has to concentrate on one rather than
two error correction mechanisms. That should make it
easier to get right.

Doug Gilbert
