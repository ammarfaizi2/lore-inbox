Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262596AbRFQSRg>; Sun, 17 Jun 2001 14:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262607AbRFQSR1>; Sun, 17 Jun 2001 14:17:27 -0400
Received: from mail.mediaways.net ([193.189.224.113]:10964 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP
	id <S262596AbRFQSRJ>; Sun, 17 Jun 2001 14:17:09 -0400
Date: Sun, 17 Jun 2001 20:11:19 +0200
From: Walter Hofmann <walter.hofmann@physik.stud.uni-erlangen.de>
To: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac15
Message-ID: <20010617201119.A2331@frodo.uni-erlangen.de>
In-Reply-To: <20010615230635.A27708@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010615230635.A27708@lightning.swansea.linux.org.uk>; from laughing@shared-source.org on Fri, Jun 15, 2001 at 11:06:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had already two crashes with ac15. The system was still ping-able, but
login over the network didn't work anymore.

The first crash happened after I started xosview and noticed that the
system almost used up the swap (for no apparent reason). The second
crash happened shortly after I started fsck on a crypto-loop device.

This does not happen with ac14, even under heavy load.

I noticed a second problem: Sometimes the system hangs completely for
approximately ten seconds, but continues just fine after that. I have
seen this with ac14 and ac15, but not with ac12.

This is a mixed IDE/SCSI (Adaptec) system, 128MB RAM/256MB swap on a
Gigabyte 440LX mainboard with a Pentium II.

Walter
