Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281488AbRLWAL5>; Sat, 22 Dec 2001 19:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282859AbRLWALm>; Sat, 22 Dec 2001 19:11:42 -0500
Received: from balu.sch.bme.hu ([152.66.208.40]:7076 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S281488AbRLWALc>;
	Sat, 22 Dec 2001 19:11:32 -0500
Date: Sun, 23 Dec 2001 01:11:24 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: "Gabor Z. Papp" <gzp@myhost.mynet>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: devfs permissions
In-Reply-To: <27e4.3c2505d3.14a5@gzp1.gzp>
Message-ID: <Pine.GSO.4.30.0112230108510.24807-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 22 Dec 2001, Gabor Z. Papp wrote:
> * Richard Gooch <rgooch@ras.ucalgary.ca>:
> |> (which worked before but won't any more) do:
> |>     REGISTER ^sound/.* PERMISSIONS root.audio 0664
> |> or something similar.
>
> And what about subdirs, like in case of /dev/ide/...
> 	REGISTER ^ide/.* PERMISSIONS root.disk 0660
> sets the permission 0660 on /dev/ide/host0/ also.

If you want to match only /dev/ide then use
       REGISTER ^ide$ PERMISSIONS root.disk 0660


-- 
pozsy

