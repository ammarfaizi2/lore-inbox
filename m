Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267637AbTAHBM7>; Tue, 7 Jan 2003 20:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267639AbTAHBM7>; Tue, 7 Jan 2003 20:12:59 -0500
Received: from hell.ascs.muni.cz ([147.251.60.186]:24193 "EHLO
	hell.ascs.muni.cz") by vger.kernel.org with ESMTP
	id <S267637AbTAHBM5>; Tue, 7 Jan 2003 20:12:57 -0500
Date: Wed, 8 Jan 2003 02:21:33 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.54 - quota support
Message-ID: <20030108012133.GA725@mail.muni.cz>
References: <20030106003801.GA522@mail.muni.cz> <3E18E2F0.1F6A47D0@digeo.com> <20030106103656.GA508@mail.muni.cz> <20030106144842.GD24714@atrey.karlin.mff.cuni.cz> <20030106151908.GA640@mail.muni.cz> <20030107164028.GC6719@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030107164028.GC6719@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4i
X-Muni: zakazka, vydelek, firma, komerce, vyplata
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, Mossad, Iraq, Pentagon, WTC, president, assassination, A-bomb, kua, vic joudu uz neznam
X-policie-CR: Neserte mi nebo ukradnu, vyloupim, vybouchnu, znasilnim, zabiju, podpalim, umucim, podriznu, zapichnu a vubec vsechno
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 05:40:28PM +0100, Jan Kara wrote:
>   Reporting 'No such device' was actually bug which was introduced some
> time ago but nobody probably noticed it... It was introduce when quota
> code was converted from device numbers to 'bdev' structures.
>   I also fixed one bug in quotaon() call however I'm not sure wheter it
> could cause the freeze. Anyway patch is attached, try it and tell me
> about the changes.

Hmm, quotaon / with init=/bin/sh seems to work OK, quota accounting is made and
repquota displays normal info.

However with normal startup quotaon / still freezes :-(


Btw, does anyone know why mount is failing for so long time while using with
automount? Process mount is in uninterruptible sleep for more than 10 secs until
reports no disc in cdrom. (the same for my usb camera when autofs try to mount
it while it is not connected).

-- 
Luká¹ Hejtmánek
