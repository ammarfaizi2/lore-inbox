Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWCaH57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWCaH57 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 02:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWCaH57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 02:57:59 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:22028 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751253AbWCaH57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 02:57:59 -0500
Date: Fri, 31 Mar 2006 09:57:58 +0200
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Float numbers in module programming
Message-ID: <20060331075758.GB93977@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <3fd7d9680603290634n6fabcdc7r193c30447acc1858@mail.gmail.com> <Pine.LNX.4.61.0603290955440.27913@chaos.analogic.com> <Pine.LNX.4.61.0603301010400.30783@yvahk01.tjqt.qr> <Pine.LNX.4.61.0603300739050.32259@chaos.analogic.com> <20060330182643.GV27173@skl-net.de> <Pine.LNX.4.61.0603301342410.1215@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0603301342410.1215@chaos.analogic.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 01:46:20PM -0500, linux-os (Dick Johnson) wrote:
> Yeah. The correct word was irrational, which is its definition. The
> point was that one can do a lot of very accurate work on real numbers
> without using the FP unit and the decimal system.

As long as you don't use sin/cos (oops, no 3D, no polar coordinates,
no FFT), sqrt (oops no lenghts), pi (oops no non-polygonal surfaces)
or ln/exp (oops, a lot of things are gone there).

Working with rationals is not that realistic nowadays except in things
like mathematica, maple and friends.  Fixed-point though is still very
realistics, it's just a different precision/scale tradeoff than fp,
and one you control.

  OG.

