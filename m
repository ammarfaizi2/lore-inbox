Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271355AbTHHNbw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 09:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271356AbTHHNbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 09:31:52 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:11538 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S271355AbTHHNbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 09:31:51 -0400
Date: Fri, 8 Aug 2003 15:26:47 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6: Problem multiple bool/tristate prompts
In-Reply-To: <20030808103717.GP16091@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0308081513560.714-100000@serv>
References: <20030807235905.GO16091@fs.tum.de> <Pine.LNX.4.44.0308081135520.714-100000@serv>
 <20030808103717.GP16091@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 8 Aug 2003, Adrian Bunk wrote:

> My problem isn't that important to satisfy such a complicated construct,
> I can accept that there's no easy way to express this and live without
> it.

Dynamically changing the symbol type isn't possible and usally not needed, 
if the driver can't be compiled as module, it has to use 'bool'. I'm 
planning to add tags (e.g. for EXPERIMENTAL), maybe in this context it 
will be easier, to better classify the brokenness of a driver, but this 
will definitively not happen for 2.6.

bye, Roman

