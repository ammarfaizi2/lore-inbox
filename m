Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285380AbRLNOEm>; Fri, 14 Dec 2001 09:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285381AbRLNOEc>; Fri, 14 Dec 2001 09:04:32 -0500
Received: from serv02.lahn.de ([195.211.46.202]:29255 "EHLO serv02.lahn.de")
	by vger.kernel.org with ESMTP id <S285380AbRLNOEZ>;
	Fri, 14 Dec 2001 09:04:25 -0500
X-Spam-Filter: check_local@serv02.lahn.de by digitalanswers.org
Date: Fri, 14 Dec 2001 08:38:34 +0100
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: Zlatko Calusic <zlatko.calusic@iskon.hr>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: emu10k1 - interrupt storm?
Message-ID: <20011214073834.GA10100@titan.lahn.de>
In-Reply-To: <Pine.LNX.4.33.0112121112450.2868-100000@sophia-sousar2.nice.mindspeed.com> <3C175A7C.6C532320@roadnet.com.br> <878zc8az65.fsf@atlas.iskon.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878zc8az65.fsf@atlas.iskon.hr>
User-Agent: Mutt/1.3.24i
Organization: UUCP-Freunde Lahn e.V.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo Zlatko!

On Wed, Dec 12, 2001 at 10:47:30PM +0100, Zlatko Calusic wrote:
> Unfortunately esd is started by the gnome desktop environment and I
> can disable or enable it, but can't set any parameters (as far as I
> can see). Probably I'll disable it for good, as emu10k1 driver already
> does a great job mixing multiple sound streams.
Say ever no:

$ fuser /dev/dsp 
/dev/dsp:             1555
$ esdctl off
$ fuser /dev/dsp 
$ ps 1555
  PID TTY      STAT   TIME COMMAND
 1555 ?        S      0:00 esd -nobeeps

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
