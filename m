Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265522AbTFMUZG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 16:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265525AbTFMUZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 16:25:05 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:9635 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265522AbTFMUZC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 16:25:02 -0400
Date: Fri, 13 Jun 2003 22:38:46 +0200
From: Vojtech Pavlik <vojtech@ucw.cz>
To: James Simmons <jsimmons@infradead.org>
Cc: Peter Berg Larsen <pebl@math.ku.dk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
Message-ID: <20030613223846.A9080@ucw.cz>
References: <20030613094435.B29859@ucw.cz> <Pine.LNX.4.44.0306132118540.29353-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0306132118540.29353-100000@phoenix.infradead.org>; from jsimmons@infradead.org on Fri, Jun 13, 2003 at 09:25:09PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 09:25:09PM +0100, James Simmons wrote:

> Just as a idea for API. How about ABS_AREA or REL_AREA instead of 
> ABS_MISC. The idea is the pressure value returned should be about 
> the same if one presses hard with one finger or softly with a whole 
> hand.

Huh? Force = Pressure x Area ... I think you're mixing up force and
pressure here.

> So to tell the difference between the two we can report the 
> pressure and the area over which it acted. Say in virtual reality 
> environment simulation poking a object hard with your finger would
> have a very different effect than placing your hand lightly on the 
> object even tho they might register about the same pressure.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
