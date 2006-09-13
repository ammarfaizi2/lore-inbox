Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWIMQcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWIMQcZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 12:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWIMQcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 12:32:24 -0400
Received: from odin2.bull.net ([129.184.85.11]:38277 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S1750895AbWIMPCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 11:02:40 -0400
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: linux-kernel@vger.kernel.org
Subject: RT, timers and CLOCK_REALTIME_HR
Date: Wed, 13 Sep 2006 17:07:51 +0200
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609131707.52280.Serge.Noiraud@bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I have one question about CLOCK_REALTIME_HR. 
Before the rt patch I used to work with this clock. ie :
hrtimers-support-3.1.1 from http://sourceforge.net/projects/high-res-timers/

With the rt patch it seems CLOCK_REALTIME_HR does not exist anymore !
Is this normal ?
The kernel speaks about that in arch/ia64/Kconfig
perhaps it should be removed !

I had a libtimers using this clock.

Is the good correction to say CLOCK_REALTIME_HR = CLOCK_REALTIME ?
I don't want to modify all my programs.

-- 
Serge Noiraud
