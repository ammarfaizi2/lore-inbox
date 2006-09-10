Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbWIJL27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWIJL27 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 07:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWIJL27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 07:28:59 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:32464 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750898AbWIJL26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 07:28:58 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4503F673.30808@s5r6.in-berlin.de>
Date: Sun, 10 Sep 2006 13:26:43 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Matt Domsch <Matt_Domsch@dell.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc5] PCI: sort device lists breadth-first
References: <20060908031422.GA4549@lists.us.dell.com> <20060908112035.f7a83983.akpm@osdl.org> <450283D5.1020404@garzik.org> <20060909121134.GC4277@ucw.cz>
In-Reply-To: <20060909121134.GC4277@ucw.cz>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> I agree with martin here. 'Lets break all the machines where people
> are currently using 2.6.x, for benefit of people currently running
> 2.4.x' is *very* bad idea.

Small correction: Not all but "only" setups which rely on device
ordering instead of persistent unique device properties are affected.
-- 
Stefan Richter
-=====-=-==- =--= -=-=-
http://arcgraph.de/sr/
