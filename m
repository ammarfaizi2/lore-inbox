Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbTETWCW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 18:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbTETWCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 18:02:22 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:29398 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261323AbTETWCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 18:02:21 -0400
Date: Tue, 20 May 2003 23:18:59 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Kendrick Hamilton <hamilton@sedsystems.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux crashes after installing a module. (Please CC hamilton@sedsystems.ca)
Message-ID: <20030520221859.GA8567@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Kendrick Hamilton <hamilton@sedsystems.ca>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0305201601040.2041-100000@sw-55.sedsystems.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305201601040.2041-100000@sw-55.sedsystems.ca>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 20, 2003 at 04:07:07PM -0600, Kendrick Hamilton wrote:
 > Hi,
 > 	We are developping a module for a custom built card. The module 
 > installs fine on some computers and not on others. All computers are 
 > running 2.4.18 or 2.4.20 kernel. Here is a dump of installing the module 
 > and linux crashing. The module is tainting the kernel (I plan on GPLing 
 > the module and if you want code for it, I can send it to you, I just don't 
 > know how to flag it as GPLed).

The tainting is easily fixed with a one liner..
MODULE_LICENSE("GPL");

Why your code crashes however, is impossible for anyone to tell without
seeing the code.

		Dave
