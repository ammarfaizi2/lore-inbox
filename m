Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131430AbRAPWvK>; Tue, 16 Jan 2001 17:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132091AbRAPWuu>; Tue, 16 Jan 2001 17:50:50 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:33697 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S131430AbRAPWuo>; Tue, 16 Jan 2001 17:50:44 -0500
Date: Tue, 16 Jan 2001 14:39:04 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: <ed@alcpress.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: SCSI partitions
In-Reply-To: <3A642C31.25392.4BF2B9@localhost>
Message-ID: <Pine.LNX.4.31.0101161428050.22734-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in part it is due to the major/minor split which only gives 4 bits for the
partition number.

if you use devfs or LVM this limit is removed.

David Lang

On Tue, 16 Jan 2001 ed@alcpress.com wrote:

> Date: Tue, 16 Jan 2001 11:10:41 -0800
> From: ed@alcpress.com
> To: linux-kernel@vger.kernel.org
> Subject: SCSI partitions
>
> Does anyone remember the reason why SCSI drives were limited to
> 15 partitions?
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
