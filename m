Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262201AbVGMSkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbVGMSkW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 14:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVGMSiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:38:02 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:64698 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262222AbVGMShy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:37:54 -0400
Date: Wed, 13 Jul 2005 20:38:04 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: Thomas Sailer <sailer@sailer.dynip.lugs.ch>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: Synaptics probe problem on Acer Travelmate 3004WTMi
Message-ID: <20050713183804.GA2072@ucw.cz>
References: <1121275408.3583.35.camel@playstation2.hb9jnx.ampr.org> <d120d500050713103222aa9c91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d500050713103222aa9c91@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 12:32:27PM -0500, Dmitry Torokhov wrote:
> On 7/13/05, Thomas Sailer <sailer@sailer.dynip.lugs.ch> wrote:
> > Hi Vojtech,
> > 
> > I've got a problem with my Acer Travelmate 3004WTMi Laptop: vanilla 2.6
> > does not detect the synaptics touchpad.
> > 
> > The problem lies within psmouse_probe: after the PSMOUSE_CMD_GETID
> > command, param[0] contains 0xfa, and not one of the expected values. If
> > I just ignore this and continue, the synaptics pad is detected and
> > everything works ok.
> > 
> 
> Hi,
> 
> Could you please provide us with debug dmesg - just boot with
> i8042.debug on kernel command line.
 
Also try the usual options ("i8042.nomux=1" and "usb-handoff"). One or
both may make the problem disappear.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
