Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbUDGLGn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 07:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbUDGLGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 07:06:43 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:64732 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S262758AbUDGLGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 07:06:39 -0400
Date: Wed, 7 Apr 2004 13:06:08 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5: keyboard lockup on a Toshiba laptop
Message-ID: <20040407110608.GR20293@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200404071222.21397.rjwysocki@sisk.pl> <Pine.LNX.4.58.0404071227430.10871@alpha.polcom.net> <20040407103934.GG20293@charite.de> <Pine.LNX.4.58.0404071247120.10871@alpha.polcom.net> <20040407105522.GN20293@charite.de> <Pine.LNX.4.58.0404071300250.10871@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0404071300250.10871@alpha.polcom.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Grzegorz Kulewski <kangur@polcom.net>:

> > > They only appear at boot time for me (just once of course). Maybe 
> > > your keyboard was disconnected or kernel was thinking that it was 
> > > disconnected and connected again?...
> > 
> > Nope. It's a laptop!
> 
> Ok, so it was connected (but it can still have not full electrical 
> contact...).

Rather unlikely, since thi snever happens with 2.4.x

> But kernel (because of some bug) can think it was reconnected and 
> initialize the driver second time making kb unusable... Can't it?

Absolutely. This whole serio stuff causes nothing but grief.

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
IT-Zentrum Standort Campus Mitte                          AIM.  ralfpostfix
