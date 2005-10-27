Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932667AbVJ0WFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932667AbVJ0WFy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 18:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbVJ0WFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 18:05:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5847 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932667AbVJ0WFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 18:05:52 -0400
Date: Thu, 27 Oct 2005 18:05:33 -0400
From: Dave Jones <davej@redhat.com>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: Re: 4GB memory and Intel Dual-Core system
Message-ID: <20051027220533.GA18773@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alejandro Bonilla <abonilla@linuxwireless.org>,
	Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
References: <1130445194.5416.3.camel@blade> <52mzkuwuzg.fsf@cisco.com> <20051027204923.M89071@linuxwireless.org> <1130446667.5416.14.camel@blade> <20051027205921.M81949@linuxwireless.org> <1130447261.5416.20.camel@blade> <20051027211203.M33358@linuxwireless.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051027211203.M33358@linuxwireless.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2005 at 05:15:50PM -0400, Alejandro Bonilla wrote:
 > On Thu, 27 Oct 2005 23:07:41 +0200, Marcel Holtmann wrote
 > > Hi Alejandro,
 > > 
 > > > > the board in this system is a Intel D945GNT and the box tells me the
 > > > > maximum supported amount of RAM is 4 GB. So there should be a way to
 > > > > address this amount memory.
 > > > 
 > > > The board did take the 4GB of RAM and it is finding them, therefore supports
 > > > them. It is just not designed to give a full 4GB of RAM to the system, it only
 > > > gives 3.4XGB RAM and the rest is really not used, then basically the system
 > > > just tries to give the 0.6xGB RAM remaining a task by it being used by "System
 > > > Resources"
 > > > 
 > > > This isn't really Linux dependant.
 > > 
 > > so there is no way to give me back the "lost" memory. Is it possible
 > > that another motherboard might help?
 > 
 > AFAIK, No. AMD and Intel will always do the same thing until we all move to
 > real IA64.

Somehow, I doubt AMD see it that way :-)

Some boards at least have a BIOS option to support 'memory hoisting'
to map the 'lost' memory above the 4G address space.

I suspect a lot of the lower-end (and older) boards however don't have
this option, as they were not tested with 4GB.

		Dave

