Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265529AbTFMUhp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 16:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265528AbTFMUho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 16:37:44 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:19206 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265529AbTFMUhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 16:37:43 -0400
Date: Fri, 13 Jun 2003 21:51:29 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Vojtech Pavlik <vojtech@ucw.cz>
cc: Peter Berg Larsen <pebl@math.ku.dk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
In-Reply-To: <20030613223846.A9080@ucw.cz>
Message-ID: <Pine.LNX.4.44.0306132140520.29353-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Just as a idea for API. How about ABS_AREA or REL_AREA instead of 
> > ABS_MISC. The idea is the pressure value returned should be about 
> > the same if one presses hard with one finger or softly with a whole 
> > hand.
> 
> Huh? Force = Pressure x Area ... I think you're mixing up force and
> pressure here.

OOps. Your right. I'm thinking the hardware returns a force value. What I 
meant is since we have the hardware returning the pressure and the area 
this data can be used. Knowing the area over which a pressure is applied 
is a good thing. What do you think?


