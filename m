Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264637AbSKRSRd>; Mon, 18 Nov 2002 13:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264639AbSKRSRd>; Mon, 18 Nov 2002 13:17:33 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:59601 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP
	id <S264637AbSKRSRb>; Mon, 18 Nov 2002 13:17:31 -0500
Message-Id: <200211181823.gAIIN1eA002882@pool-151-204-203-202.delv.east.verizon.net>
Date: Mon, 18 Nov 2002 13:22:57 -0500
From: Skip Ford <skip.ford@verizon.net>
To: Jochen Hein <jochen@jochen.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.48] Config.help misleading
References: <871y5iuajl.fsf@gswi1164.jochen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <871y5iuajl.fsf@gswi1164.jochen.org>; from jochen@jochen.org on Mon, Nov 18, 2002 at 05:06:54PM +0100
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out001.verizon.net from [151.204.203.202] at Mon, 18 Nov 2002 12:24:28 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jochen Hein wrote:
> Help says to say "Y" if unsure, but that isn't allowed:
> ,----
> |   UHCI HCD (most Intel and VIA) support (USB_UHCI_HCD) [N/m/?] (NEW) ?
> | 
[snip]
> | 133). If unsure, say Y.
> | 
> |   UHCI HCD (most Intel and VIA) support (USB_UHCI_HCD) [N/m/?] (NEW) y
> `----

Did you choose to make USB support a module?  If you said 'y' to USB
support, then you should have a 'y' option above.  However, you most
likely said 'm' for USB support so 'm' is all you can do for this
because it depends on it.  Had you said 'n' to USB support, you wouldn't
be able to select 'y' or 'm' for the above.

-- 
Skip
