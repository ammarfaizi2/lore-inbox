Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269260AbTGJMno (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 08:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269261AbTGJMno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 08:43:44 -0400
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:57610 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S269260AbTGJMnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 08:43:43 -0400
Date: Thu, 10 Jul 2003 07:58:21 -0500
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Subject: Success with Turtle Beach Malibu soundcard and 2.5.74-bk
Message-ID: <20030710125821.GE18740@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The latest 2.5.74-bk kernel have resolved the PnP issues that had
stopped my Turtle Beach Malibu sound card from working. Previously
trying to activate the card always failed, but I'm pleased to say that
it now works ...

$ cat /proc/asound/cards
0 [CS4237B        ]: CS4237B - CS4237B
                     CS4237B at 0x534, irq 5, dma 1&3
$

My thanks to the ALSA and PnP maintainers for achieving this.

Art Haas

-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
