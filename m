Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317415AbSIELOA>; Thu, 5 Sep 2002 07:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317422AbSIELOA>; Thu, 5 Sep 2002 07:14:00 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:145 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S317415AbSIELN7>; Thu, 5 Sep 2002 07:13:59 -0400
Date: Thu, 5 Sep 2002 12:17:17 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Gabriel Paubert <paubert@iram.es>
Cc: Hirokazu Takahashi <taka@valinux.co.jp>, hpa@zytor.com,
       linux-kernel@vger.kernel.org
Subject: Re: TCP Segmentation Offloading (TSO)
Message-ID: <20020905121717.A15540@kushida.apsleyroad.org>
References: <20020905.111326.68164898.taka@valinux.co.jp> <Pine.LNX.4.33.0209051219000.21098-100000@gra-lx1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0209051219000.21098-100000@gra-lx1.iram.es>; from paubert@iram.es on Thu, Sep 05, 2002 at 12:28:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel Paubert wrote:
> Now that is grossly inefficient ;-) since you can save one instruction by
> moving roll after adcl (hand edited partial patch hunk, won't apply):

Yes but is it _faster_? :-)

I've been doing some PPro assembly lately, and I'm reminded that
sometimes inserting instructions can reduce the timing by up to 8 cycles
or so.

-- Jamie
