Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbUKSOWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbUKSOWX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 09:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbUKSOUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 09:20:20 -0500
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:19645 "EHLO
	gw01.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S261431AbUKSOTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 09:19:47 -0500
Date: Fri, 19 Nov 2004 16:19:45 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
To: alsa-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Maestro3 hw volume buttons on HP OB6000 (need help from HP)
Message-ID: <20041119141945.GA27175@sci.fi>
Mail-Followup-To: alsa-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying to get the hardware volume buttons to work on my HP 
OmniBook 6000 laptop. The audio chip is an ESS Maestro 3 and the specs are 
available. Unfortunately that doesn't seem to be enough to make the 
buttons work.

There is something messing with hw volume pins since I get a constant 
flood of events. I can't enable the hw volume interrupt because the system 
will hang under the interrupt load. It does appear that the the buttons 
are actually connected to the right pins since I can see some changes in 
the data when I press the buttons (observed using another interrupt 
source).

The laptop requires a HP specific driver even under Windows. Otherwise the 
hw volume buttons don't behave properly (mute and vol up act as mute, vol 
down does nothing). The standard driver doesn't hang the machine though.

I'd really appreciate some help from HP.

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/
