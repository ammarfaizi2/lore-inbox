Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272309AbTG3WYQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 18:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272299AbTG3WYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 18:24:15 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:55269 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S272309AbTG3WX3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 18:23:29 -0400
Date: Wed, 30 Jul 2003 18:22:28 -0400 (EDT)
From: Richard A Nelson <cowboy@vnet.ibm.com>
To: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm1 & ipsec-tools (xfrm_type_2_50?)
In-Reply-To: <20030730214219.GA23265@localhost>
Message-ID: <Pine.LNX.4.56.0307301819380.9619@onqynaqf.yrkvatgba.voz.pbz>
References: <Pine.LNX.4.56.0307301515250.26621@onqynaqf.yrkvatgba.voz.pbz>
 <20030730214219.GA23265@localhost>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jul 2003, Jose Luis Domingo Lopez wrote:

> > most of the module not found messages are fine, its xfrm_type_2_50 that
> > I'm worried about... What am I missing ?
> >
> Maybe your kernel is missing "< > IPsec user configuration interface"
> under "Networking options".

CONFIG_XFRM_USER=m
$ lsmod | grep xfrm
xfrm_user              15364  0

-- 
Rick Nelson
<core> i'm glad Debian finally got into
        polar-deep-freeze-we-arent-shitting-you state finally.
	-- Seen on #Debian shortly before the release of Debian 2.0
