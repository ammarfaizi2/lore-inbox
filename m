Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316199AbSGIQPX>; Tue, 9 Jul 2002 12:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316235AbSGIQPW>; Tue, 9 Jul 2002 12:15:22 -0400
Received: from pD9E238F8.dip.t-dialin.net ([217.226.56.248]:36320 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316199AbSGIQPV>; Tue, 9 Jul 2002 12:15:21 -0400
Date: Tue, 9 Jul 2002 10:17:50 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Piotr Sawuk <a9702387@unet.univie.ac.at>
cc: linux-kernel@vger.kernel.org, <vojtech@suse.cz>
Subject: Re: joystick.c
In-Reply-To: <3D2AB938.52461BDE@unet.univie.ac.at>
Message-ID: <Pine.LNX.4.44.0207091016130.10105-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 9 Jul 2002, Piotr Sawuk wrote:
> if (value < -32767) return -32767;
> if (value > 32767) return 32767;
> 
> what's the use of these? I'm asking because my new usb-joystick
> is returning those values somewhere in the middle of it's threshold
> and I was wondering if disabling the above would do any good?

That's just:
We don't return values below -32,767
We don't return values above 32,767

So your values are OK as long as they don't exceed [-32,767:32,767]

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

