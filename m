Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262882AbVBCLVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbVBCLVi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 06:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbVBCLVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 06:21:36 -0500
Received: from main.gmane.org ([80.91.229.2]:34449 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262920AbVBCLUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 06:20:48 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: [PATCH 3/4] Fix "pointer jumps to corner of screen" problem on ALPS Glidepoint touchpads.
Date: Thu, 3 Feb 2005 12:18:10 +0100
Message-ID: <MPG.1c6c19f1476bb4a98970e@news.gmane.org>
References: <m34qgz9pj5.fsf@telia.com> <m3zmyr8avm.fsf@telia.com> <m3vf9f8asf.fsf_-_@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-116-150.29-151.libero.it
User-Agent: MicroPlanet-Gravity/2.70.2067
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund wrote:
> Only parse a "z == 127" packet as a relative Dualpoint stick packet if
> the touchpad actually is a Dualpoint device.  The Glidepoint models
> don't have a stick, and can report z == 127 for a very wide finger. If
> such a packet is parsed as a stick packet, the mouse pointer will
> typically jump to one corner of the screen.

I remember reading specs of a touchpad (can't remember if it 
was ALPS or Synaptics) (driver) which could do "palm 
detection" (basically ignoring events when a large part of the 
hand accidentally touched/pressed the pad, FWICS).

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

