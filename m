Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268453AbTGLUJH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 16:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268454AbTGLUJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 16:09:07 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:43950 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S268453AbTGLUJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 16:09:04 -0400
Date: Sat, 12 Jul 2003 21:26:22 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: agpgart, nforce2, radeon and agp fastwrite
Message-ID: <20030712202622.GB7741@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jan Dittmer <j.dittmer@portrix.net>, linux-kernel@vger.kernel.org
References: <3F102E8E.4030507@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F102E8E.4030507@portrix.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 12, 2003 at 05:51:42PM +0200, Jan Dittmer wrote:
 > just took me half a hour to figure out. On nforce2 you have to disable 
 > agp fastwrites, otherwise X locks hard on startup with the following 
 > (from serial console).
 > ...
 > 
 > Without AGP Fastwrites turned on, it all works wonderful. Just if 
 > anybody encounters the same problem.
 > Mainboard is nForce2 based, graphics is radeon 8500le (R200).

Could be that the nforce & radeon don't play well together.
Anyone using fast writes without problems with non-ATI cards & nforce ?
If it works there, it's trivial to blacklist ATI cards and make them
unable to enable fast writes in the gart driver.

		Dave

