Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbUL0VIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbUL0VIX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 16:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbUL0VIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 16:08:23 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:27529 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S261984AbUL0VIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 16:08:20 -0500
Date: Mon, 27 Dec 2004 21:08:44 +0000
From: Karel Kulhavy <clock@twibright.com>
To: Domen Puncer <domen@coderock.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i2c-parport boot time parameters
Message-ID: <20041227210844.GC6091@beton.cybernet.src>
References: <20041227132307.GA3247@beton.cybernet.src> <20041227172739.GB18084@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041227172739.GB18084@nd47.coderock.org>
User-Agent: Mutt/1.4.2.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2004 at 06:27:39PM +0100, Domen Puncer wrote:
> On 27/12/04 13:23 +0000, Karel Kulhavy wrote:
> > Hello
> > 
> > Is it possible to configure i2c-parport driver using boot time commandline
> > parameters? If so, where are these parameters described? I found just
> > description of module parameters using modinfo i2c-parport.
> 
> Yes, for modules that use module_param (i2c-parport does), you can
> use module.parameter=blah in boot line.

How do I determine whether module uses module_param without examining the
code? Does running modinfo suffice?

> 
> This is described in Documentation/kernel-parameters.txt

Thanks. I have updated the information on I2C2P homepage.

Cl<
> 
> 
> 	Domen
