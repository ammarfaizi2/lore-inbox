Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbRACW5r>; Wed, 3 Jan 2001 17:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbRACW5h>; Wed, 3 Jan 2001 17:57:37 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:22001 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129413AbRACW5Y>; Wed, 3 Jan 2001 17:57:24 -0500
Date: Wed, 3 Jan 2001 20:56:55 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: linux-lvm@sistina.com
cc: linux-kernel@vger.kernel.org
Subject: LVM 0.9 vgscan problem
Message-ID: <Pine.LNX.4.21.0101032054040.1917-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a strange problem (preventing me from testing the latest
2.4 kernel ... *sigh*) with my LVM setup.

The latest LVM utils + the latest kernel works just fine on my
test machine, but breaks horribly on my workstation. The only
difference I have found is that one PV of my VG has "NOT available"
as PV Status ...

--- Physical volume ---
PV Name               /dev/hda5
VG Name               vg0
PV Size               4.4 GB / NOT usable 2.56 MB [LVM: 124 KB]
PV#                   3
PV Status             NOT available
Allocatable           yes
Cur LV                0
PE Size (KByte)       4096
Total PE              1125
Free PE               1125
Allocated PE          0

Any chance of getting the LVM utilities fixed ?

I'd hate to see LVM be the showstopper for 2.4
(then again, the way the LVM team has neglected
everything from backwards compatability to even
documenting such is pretty much a showstopper in
itself ...)

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
