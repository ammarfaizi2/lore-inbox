Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265524AbTFMULt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 16:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265520AbTFMULc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 16:11:32 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:4358 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265521AbTFMUL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 16:11:27 -0400
Date: Fri, 13 Jun 2003 21:25:09 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Vojtech Pavlik <vojtech@ucw.cz>
cc: Peter Berg Larsen <pebl@math.ku.dk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
In-Reply-To: <20030613094435.B29859@ucw.cz>
Message-ID: <Pine.LNX.4.44.0306132118540.29353-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just as a idea for API. How about ABS_AREA or REL_AREA instead of 
ABS_MISC. The idea is the pressure value returned should be about 
the same if one presses hard with one finger or softly with a whole 
hand. So to tell the difference between the two we can report the 
pressure and the area over which it acted. Say in virtual reality 
environment simulation poking a object hard with your finger would
have a very different effect than placing your hand lightly on the 
object even tho they might register about the same pressure.

