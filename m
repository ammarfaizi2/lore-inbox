Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266891AbUFYX3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266891AbUFYX3t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 19:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266890AbUFYX2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 19:28:41 -0400
Received: from smtp.terra.es ([213.4.129.129]:10435 "EHLO tsmtp1.mail.isp")
	by vger.kernel.org with ESMTP id S266888AbUFYX1h convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 19:27:37 -0400
Date: Sat, 26 Jun 2004 01:26:20 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Scheduler: -mm vs -staircase
Message-Id: <20040626012620.0622a3af.diegocg@teleline.es>
In-Reply-To: <20040625225654.GC4453@werewolf.able.es>
References: <20040625221042.GA4453@werewolf.able.es>
	<20040625225654.GC4453@werewolf.able.es>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sat, 26 Jun 2004 00:56:54 +0200 "J.A. Magallon" <jamagallon@able.es> escribió:


> I start /usr/lib/xscreensaver/glmatrix -fps, and the frame rate starts at
> 25 fps. In 30 seconds it has dropped to 6 fps. The app is still using 
> the same cpu time (about 90% of one cpu on a dual xeon box with ht).

For that particular screensaver, notice that glmatrix starts drawing nothing.
30 seconds after the start there're lots of polygons so after 20 seconds
it needs more processing power. It happens exactly the same
but the difference is not so big, from 30fps to 24fps, perhaps
you didn't enabled DRI acceleration?
