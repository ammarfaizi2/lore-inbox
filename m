Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277072AbRJ0Uf4>; Sat, 27 Oct 2001 16:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277083AbRJ0Ufr>; Sat, 27 Oct 2001 16:35:47 -0400
Received: from h24-68-82-46.vc.shawcable.net ([24.68.82.46]:45067 "HELO
	brewt.org") by vger.kernel.org with SMTP id <S277072AbRJ0Ufc>;
	Sat, 27 Oct 2001 16:35:32 -0400
Date: Sat, 27 Oct 2001 13:36:07 -0700 (PDT)
From: BH <xcp@brewt.org>
To: <linux-kernel@vger.kernel.org>
Subject: "free" buffer field
Message-ID: <Pine.LNX.4.30.0110271331540.15880-100000@stinky.brewt.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What does it mean when the field marked XXXXX is negative?

             total       used       free     shared    buffers     cached
Mem:       1028936      42792     986144          0       1072      24512
-/+ buffers/cache:      XXXXX    1011728
Swap:       787176          0     787176

(This was not the output at the time)

System is 2.4.12 with 1GB ram, P3 550 BX chipset.  I had a mounted ro NTFS
playing a 100mb mp3 with mpg123.  The Mem free field was rapidly declining
during this, and XXXXX was becoming more and more negative.  It all
stopped when I killed mpg123 and umounted the NTFS.

Thanks.

