Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262520AbUCRLU7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 06:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262521AbUCRLU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 06:20:59 -0500
Received: from h42n2fls34o811.telia.com ([217.208.99.42]:25141 "EHLO dmac")
	by vger.kernel.org with ESMTP id S262520AbUCRLU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 06:20:58 -0500
Date: Thu, 18 Mar 2004 12:20:57 +0100
From: Samuel Rydh <samuel@ibrium.se>
To: linux-kernel@vger.kernel.org
Cc: Micha? Roszka <michal@roszka.pl>, pochini@denise.shiny.it
Subject: Re: [.config] CONFIG_THERM_WINDTUNNEL
Message-ID: <20040318112057.GC3686@ibrium.se>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Micha? Roszka <michal@roszka.pl>, pochini@denise.shiny.it
References: <200403180821.44199.michal@roszka.pl> <Pine.LNX.4.58.0403181012300.29633@denise.shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403181012300.29633@denise.shiny.it>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 10:16:28AM +0100, Giuliano Pochini wrote:
> > How does G4 Windtunnel thermal support work? Does it make 
> > an ability to change fans speed by the OS or maybe something
> > other/else?
> 
> Yes, it works. It controls the speed of the CPU fan according to the
> temperature. Do not forget to load the i2c_keywest module.

Nice to see that this driver has made it into the kernel tree :-).

I've been thinking about adding proper sysfs and make things
somewhat customable from userspace. I'm not quite sure the working
point is optimal for all machines (the ambient temperature is also
a factor).

Btw, I would like to get reports about how well this driver works
with respect to noise reduction. I'm in particular interested
in the dual 1.4 GHz model...

/Samuel
