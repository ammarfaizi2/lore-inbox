Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273323AbTG3TQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 15:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273324AbTG3TQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 15:16:57 -0400
Received: from www.13thfloor.at ([212.16.59.250]:38570 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S273323AbTG3TQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 15:16:52 -0400
Date: Wed, 30 Jul 2003 21:16:59 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: Pavel Machek <pavel@suse.cz>, John Bradford <john@grabjohn.com>,
       linux-kernel@vger.kernel.org, pgw99@doc.ic.ac.uk
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem ever
Message-ID: <20030730191658.GD7260@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Marc Giger <gigerstyle@gmx.ch>,
	Pavel Machek <pavel@suse.cz>, John Bradford <john@grabjohn.com>,
	linux-kernel@vger.kernel.org, pgw99@doc.ic.ac.uk
References: <200307301608.h6UG8YQJ000339@81-2-122-30.bradfords.org.uk> <20030730174457.GI10276@atrey.karlin.mff.cuni.cz> <20030730185659.GA7260@www.13thfloor.at> <20030730210618.5af8e5bb.gigerstyle@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030730210618.5af8e5bb.gigerstyle@gmx.ch>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 09:06:18PM +0200, Marc Giger wrote:
> On Wed, 30 Jul 2003 20:56:59 +0200
> Herbert Pötzl <herbert@13thfloor.at> wrote:
> > On Wed, Jul 30, 2003 at 07:44:57PM +0200, Pavel Machek wrote:

[incredible useful info zapped here]

> > anyway, parport should be short circuit safe, so
> > the worst what could happen is, that the leds are
> > not working ;) ...
> 
> Are you sure?? I thought this is true for serial-port...

I said 'should', for serial it would have been 'must' ;)

http://www.amontec.com/ieee1284_electrical.shtml
or search for the IEEE docs ... 

modern chips work at ~15mA/2.5V ... according to spec

best,
Herbert
