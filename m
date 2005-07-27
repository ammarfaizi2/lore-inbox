Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbVG0HwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbVG0HwJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 03:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVG0HwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 03:52:09 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:37824 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261979AbVG0HwH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 03:52:07 -0400
Date: Wed, 27 Jul 2005 00:51:57 -0700
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Marc Ballarin <Ballarin.Marc@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ250 vs. HZ1000
Message-ID: <20050727075156.GC25827@atomide.com>
References: <20050725161333.446fe265.Ballarin.Marc@gmx.de> <20050725155322.GA1046@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050725155322.GA1046@openzaurus.ucw.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [050725 08:57]:
> 
> USB devices prevent entering C3 and any interesting powersaving,
> try without USB...

Why do USB devices prevent C3? If it was because of the timer polling
in the root hub, I believe that should be fixed now.

Or is there some other reason?

Tony
