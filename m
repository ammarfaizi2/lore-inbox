Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313384AbSDUKpk>; Sun, 21 Apr 2002 06:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313385AbSDUKpj>; Sun, 21 Apr 2002 06:45:39 -0400
Received: from pc132.utati.net ([216.143.22.132]:56218 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S313384AbSDUKpi>; Sun, 21 Apr 2002 06:45:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Thunder from the hill <thunder@ngforever.de>,
        "Trever L. Adams" <tadams-lists@myrealbox.com>
Subject: Re: power off (again)
Date: Sun, 21 Apr 2002 00:47:03 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Christian Schoenebeck <christian.schoenebeck@epost.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0204201722470.26337-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020421110606.6818747B@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 April 2002 07:24 pm, Thunder from the hill wrote:
> Hi,
>
> On 20 Apr 2002, Trever L. Adams wrote:
> > It is reversed.  If you want power off, you do need the -p.
>
> Sure. I accidently mixed those files... As you could see, the halt was
> removed, the halt~ inserted...
>
> Regards,
> Thunder

In any case, I just re-verified: "halt -p", as root, from the command line, 
takes the machine down to the "Power down" message, parks the hard drive, but 
leaves the rest of the system on.  This is on both a linux from scratch 
system and a Red Hat system, both of which have been known to power down 
before (with a different kernel).

It still might be my .config, although a config that produces a kernel that 
powers down for suspend but won't power down on halt, on three radically 
different systems (dell, toshiba, sis)...

I'll thump on it some more later.

Rob
