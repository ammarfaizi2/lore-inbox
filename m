Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270274AbRH1Go4>; Tue, 28 Aug 2001 02:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270271AbRH1Gor>; Tue, 28 Aug 2001 02:44:47 -0400
Received: from [213.97.184.209] ([213.97.184.209]:1152 "HELO piraos.com")
	by vger.kernel.org with SMTP id <S270269AbRH1Goe>;
	Tue, 28 Aug 2001 02:44:34 -0400
Date: Tue, 28 Aug 2001 08:44:49 +0200 (CEST)
From: German Gomez Garcia <german@piraos.com>
To: Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: SCSI Error?
In-Reply-To: <Pine.LNX.4.33.0108280613280.220-100000@hal9000.piraos.com>
Message-ID: <Pine.LNX.4.33.0108280839540.867-100000@hal9000.piraos.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2001, German Gomez Garcia wrote:

> On Tue, 28 Aug 2001, German Gomez Garcia wrote:
>
> > 	Hello,
> >
> > 	I would like to know what the attached error mean, I'm using
> > 2.4.9-ac3, and I don't know if one of my disk has died, it's currently
> > working, but I would like to know if that is a hardware error or just a
> > kernel problem.
>
> 	Well, it seems to be a kernel problem, as it happens almost
> inmediately after reboot with 2.4.9-ac3 (also with 2.4.9-ac1) It doesn't
> happens with 2.4.7-ac9 and I'm currently going down to 2.4.8-ac11 (before
> 2.4.9 merge in -ac tree?) I'll report later.

	Finally it was a hardware problem, both fans that cooled the hard
disks died at the same time, so the HDs were getting really hot, and it
seems that 2.4.7 doesn't play with the HD with the swap partition on it so
hard as 2.4.9 (the only way I could explain why 2.4.7 didn't crash and
2.4.9 crashed almost after boot). Sorry to bother you with hardware
problems, but two fans at the same time ... that's bad luck!

	Regards,

	- german

-------------------------------------------------------------------------
German Gomez Garcia          | Send email with "SEND GPG KEY" as subject
<german@piraos.com>          | to receive my GnuPG public key.

