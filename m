Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262063AbRETQAn>; Sun, 20 May 2001 12:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262061AbRETQAe>; Sun, 20 May 2001 12:00:34 -0400
Received: from geos.coastside.net ([207.213.212.4]:4048 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S262063AbRETQAS>; Sun, 20 May 2001 12:00:18 -0400
Mime-Version: 1.0
Message-Id: <p05100304b72d9979094a@[207.213.214.37]>
In-Reply-To: <20010521021619.A6946@metastasis.f00f.org>
In-Reply-To: <811opRpHw-B@khms.westfalen.de>
 <Pine.LNX.4.21.0105151107290.2112-100000@penguin.transmeta.com>
 <p05100316b7272cdfd50c@[207.213.214.37]> <811opRpHw-B@khms.westfalen.de>
 <p05100301b72a335d4b61@[10.128.7.49]> <81BywVLHw-B@khms.westfalen.de>
 <p0510031eb72c5f11b8c7@[207.213.214.37]>
 <20010521021619.A6946@metastasis.f00f.org>
Date: Sun, 20 May 2001 08:57:09 -0700
To: Chris Wedgwood <cw@f00f.org>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: LANANA: To Pending Device Number Registrants
Cc: Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 2:16 AM +1200 2001-05-21, Chris Wedgwood wrote:
>On Sat, May 19, 2001 at 10:36:14AM -0700, Jonathan Lundell wrote:
>
>     I know from system documentation, or can figure out once and for
>     all by experimentation, the correspondence between PCI
>     bus/dev/fcn and physical locations. Jeff's extension gives me the
>     mapping between eth# and PCI bus/dev/fcn, which is not otherwise
>     available (outside the kernel).
>
>Won't work with hotplug PCI (consider plugging in something with a
>bridge).

It's true that hotplug devices make it more complicated, but I think 
the result can be achieved by describing the correspondence 
topologically rather than as a simple b/d/f-to-location table.
-- 
/Jonathan Lundell.
