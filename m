Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276615AbRI2Umw>; Sat, 29 Sep 2001 16:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276616AbRI2Umn>; Sat, 29 Sep 2001 16:42:43 -0400
Received: from 65-45-81-178.customer.algx.net ([65.45.81.178]:46350 "EHLO
	master.aslab.com") by vger.kernel.org with ESMTP id <S276615AbRI2UmZ>;
	Sat, 29 Sep 2001 16:42:25 -0400
Date: Sat, 29 Sep 2001 13:26:43 -0700 (PDT)
From: Andre Hedrick <andre@aslab.com>
To: Dave Jones <davej@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: RFC (patch below) Re: ide drive problem?
In-Reply-To: <Pine.LNX.4.30.0109292229380.21394-100000@Appserv.suse.de>
Message-ID: <Pine.LNX.4.31.0109291325410.7545-100000@postbox.aslab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry ABORTED commands are reported ad valid errors.
The case of SMART errors is that SMART may not be enabled in the device.

Cheers,

Andre Hedrick
CTO ASL, Inc.
Linux ATA Development
-----------------------------------------------------------------------------
ASL, Inc.                                    Tel: (510) 857-0055 x103
38875 Cherry Street                          Fax: (510) 857-0010
Newark, CA 94560                             Web: www.aslab.com

On Sat, 29 Sep 2001, Dave Jones wrote:

> On Sat, 29 Sep 2001, Andre Hedrick wrote:
>
> > This is an error that I am considering removing form the user's view.
> > For the very fact/reason you are pointing out; however, it becomse
> > more painful when performing error sorting.
>
> Another 'error' you may want to silence some time is the one
> that appears when you query SMART status of a recent IBM drive.
>
> hde: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> hde: drive_cmd: error=0x04 { DriveStatusError }
>
> This happens if the drive is SMART capable, but not SMART enabled,
> and you ask it if it can do SMART.  Once you enable it, subsequent
> queries work without spitting out the error.
> (Unless you turn it off again)
>
> I'm not sure if this a quirk of these drives (I've not seen it happen
> on any other vendor), or the code.
>
> regards,
>
> Dave.
>
> --
> | Dave Jones.        http://www.suse.de/~davej
> | SuSE Labs
>

