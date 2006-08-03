Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWHCPnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWHCPnJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 11:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWHCPnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 11:43:09 -0400
Received: from metis.extern.pengutronix.de ([83.236.181.26]:33668 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S964811AbWHCPnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 11:43:08 -0400
Date: Thu, 3 Aug 2006 17:42:43 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Jim Cromie <jim.cromie@gmail.com>,
       Robert Schwebel <r.schwebel@pengutronix.de>,
       Chris Boot <bootc@bootc.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Proposal: common kernel-wide GPIO interface
Message-ID: <20060803154243.GH10495@pengutronix.de>
References: <44CA7738.4050102@bootc.net> <20060730130811.GI10495@pengutronix.de> <44CFC6CC.8020106@gmail.com> <20060802175834.GA13641@csclub.uwaterloo.ca> <44D10FA1.2010206@gmail.com> <20060803135558.GO13639@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20060803135558.GO13639@csclub.uwaterloo.ca>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 09:55:58AM -0400, Lennart Sorensen wrote:
> > I'll rephrase my Q here.
> > 
> > /sys/class/gpio/gpio63/
> > 
> > this suggests that either - only 1 GPIO device can register (bad)
> 
> Unacceptably bad.  I currently use anywhere from 2 to 4 different
> devices with GPIOs.

Sure, it would probably be nice to have GPIO devices in sysfs dirs of
their respective parent. The variant I've sent was just a quick-n-dirty
framework we hacked for a project. 

Robert 
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

