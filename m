Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292976AbSB0Vfj>; Wed, 27 Feb 2002 16:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292977AbSB0Vek>; Wed, 27 Feb 2002 16:34:40 -0500
Received: from kraid.nerim.net ([62.4.16.95]:62984 "HELO kraid.nerim.net")
	by vger.kernel.org with SMTP id <S292974AbSB0VeD>;
	Wed, 27 Feb 2002 16:34:03 -0500
Date: Wed, 27 Feb 2002 22:33:59 +0100
To: Allo!Allo! <lachinois@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel module ethics.
Message-ID: <20020227213359.GD32288@calixo.net>
In-Reply-To: <F82zxvoEaZWNaBJjvmZ00001183@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F82zxvoEaZWNaBJjvmZ00001183@hotmail.com>
User-Agent: Mutt/1.3.27i
X-Face: "99`N"mZV/:<T->OLp[>#d3R;u.!ivtwAEpIQDL8rD#;L3Wm)~^)Uv=#;S!LZf1y8oRY7J#JR\Lr{*4Cn*32C89ln>0~5~tm--}j%hvhj+vtW><xbwA=@G8M||zPV0-r`:6zhMqq+_OC_0W*-:Wxzm3%|A5EE}VFnIgRU=+,L-hGdM"j&l'_^zK+%MBOsdmi#e3(3fGg^SGM
From: Cyrille Chepelov <cyrille@chepelov.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

> The other compromise is to write a closed source part that would not permit 
> the driver to work with another card supporting the same chipset. Is this 
> kind of practice generally accepted or is it frowned upon? The motive of 
> the company is quite clear. If people want to "improve" the driver, they 
> can only improve it for their hardware, not the competitors. There is also 
> a big marketing sales pitch that goes like "we support linux, the others 
> don&#8217;t..."

If you can detect that it is indeed your company's card and not the
competitors (who seemingly uses the same chipset), perhaps your
closed-source userland firmware load utility could take advantage of this to
refuse to load the firmware if the right implementation of the device is not
found? This'd allow you to keep the kernel driver open and still satisfy the
requirement of "screw the competition".

Just my 2¢.

	-- Cyrille

-- 
Grumpf.

