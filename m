Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265871AbUAKOWb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 09:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265882AbUAKOWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 09:22:31 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:42451 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265871AbUAKOW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 09:22:26 -0500
Date: Sun, 11 Jan 2004 15:22:13 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Peter Berg Larsen <pebl@math.ku.dk>
Cc: Gunter =?iso-8859-1?Q?K=F6nigsmann?= <gunter.koenigsmann@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Synaptics Touchpad workaround for strange behavior after Sync loss (With Patch).
Message-ID: <20040111142213.GB28148@ucw.cz>
References: <Pine.LNX.4.53.0401110935010.1395@calcula.uni-erlangen.de> <Pine.LNX.4.40.0401111347320.16947-100000@shannon.math.ku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.40.0401111347320.16947-100000@shannon.math.ku.dk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 11, 2004 at 01:52:46PM +0100, Peter Berg Larsen wrote:
> 
> On Sun, 11 Jan 2004, Gunter Königsmann wrote:
> 
> > Hmmm... Now I get an "Reverted to legacy aux mode" after about every third
> > resync of the driver, and sometimes odd and sometimes even numbers of sync
> > losses...
> 
> How often is that? X/minute. I do not expect many "reverted .." messages,
> but if there is, then I believe the mux ver 1.1 has added some extra error
> codes that we se as a revert.

Or the BIOS powermanagement is touching the controller in a way the MUX
mode doesn't like ...

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
