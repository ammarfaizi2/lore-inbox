Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282999AbRLWAOR>; Sat, 22 Dec 2001 19:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283002AbRLWAOH>; Sat, 22 Dec 2001 19:14:07 -0500
Received: from balu.sch.bme.hu ([152.66.208.40]:41636 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S282999AbRLWANx>;
	Sat, 22 Dec 2001 19:13:53 -0500
Date: Sun, 23 Dec 2001 01:13:46 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: devfs permissions
Message-ID: <Pine.GSO.4.30.0112230113230.24807-100000@balu>
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


