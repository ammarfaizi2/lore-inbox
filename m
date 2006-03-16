Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752324AbWCPQHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324AbWCPQHs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 11:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752383AbWCPQHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 11:07:48 -0500
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:11452 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752324AbWCPQHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 11:07:47 -0500
Date: Thu, 16 Mar 2006 08:07:43 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Greg Scott <GregScott@InfraSupportEtc.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
       Bart Samwel <bart@samwel.tk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Simon Mackinlay <smackinlay@mail.com>
Subject: Re: Router stops routing after changing MAC Address
Message-ID: <20060316160743.GA13035@taniwha.stupidest.org>
References: <925A849792280C4E80C5461017A4B8A20321F2@mail733.InfraSupportEtc.com> <20060313100041.212cee08@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060313100041.212cee08@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 10:00:41AM -0800, Stephen Hemminger wrote:

> There still is a bug in the 3c59x driver.  It doesn't include any
> code to handle changing the mac address.  It will work if you take
> the device down, change address, then bring it up. But you shouldn't
> have to do that.

I sent a patch do to this probably a year or two back and it was
rejected (by akpm if I recall) because of the argument that you could
and should take it down, change the MAC and bring it back up.

Is this no longer a requirement?

