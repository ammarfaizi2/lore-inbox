Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271504AbTGQQxD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 12:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271508AbTGQQxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 12:53:03 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:9145 "EHLO
	genius.impure.org.uk") by vger.kernel.org with ESMTP
	id S271504AbTGQQw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 12:52:56 -0400
Date: Thu, 17 Jul 2003 18:07:09 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: James Simmons <jsimmons@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, dank@reflexsecurity.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test1-ac1 Matrox Compile Error
Message-ID: <20030717170708.GB4280@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	James Simmons <jsimmons@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, dank@reflexsecurity.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030715175758.GC15505@suse.de> <Pine.LNX.4.44.0307171801330.10255-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307171801330.10255-100000@phoenix.infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 06:03:02PM +0100, James Simmons wrote:

 > Strange that CONFIG_VT would get set to no. Another huge issue is that 
 > people are configuring several framebuffer drivers to run the same piece 
 > of hardware. 

A number of people seem to be seeing regressions with vesafb too.
Configs that worked with 2.4 give a blank screen, and lock up under 2.5
I believe vga=791 was one such option.

		Dave

