Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277144AbRJVRLS>; Mon, 22 Oct 2001 13:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277135AbRJVRK6>; Mon, 22 Oct 2001 13:10:58 -0400
Received: from a-pr10-15.tin.it ([212.216.147.238]:23174 "EHLO
	eris.discordia.loc") by vger.kernel.org with ESMTP
	id <S277188AbRJVRKw>; Mon, 22 Oct 2001 13:10:52 -0400
Date: Mon, 22 Oct 2001 19:11:22 +0200 (CEST)
From: Lorenzo Marcantonio <lomarcan@tin.it>
To: <linux-kernel@vger.kernel.org>
Subject: Re: VIA 686b Bug - once again :(
In-Reply-To: <m3wv1n7guj.fsf@shakti.rupa.com>
Message-ID: <Pine.LNX.4.31.0110221907510.30106-100000@eris.discordia.loc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2001, Rupa Schomaker wrote:

> Adaptec or Advansys scsi controller.  A 2.5G file dump to tape would
> never restore the same.  One the Adaptec card, I would get 1 or 2
> blocks of 64bytes that would differ.  On the Advansys it would be 1 or
> 2 blocks of 63 bytes.

Some month ago (about at 2.4.6 kernel) I've got the same problem with my
DDS3 (the TAPE CORRUPTION thread). 64 bytes more or less aligned at page
boundary. Tought it was the tape driver, it was an Adaptec driver issue
(back to when you needed Berkeley DB to compile the firmware)!
Now it works perfectly (and I've got an infamous Asus A7V...). BTW no HDD
on secondary IDE, only a CDROM :)

-- Lorenzo Marcantonio

