Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbTEULEF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 07:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbTEULEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 07:04:05 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:5258 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S262029AbTEULEE (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 21 May 2003 07:04:04 -0400
Date: Wed, 21 May 2003 12:21:15 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Hadmut Danisch <hadmut@danisch.de>
Cc: Linux-Kernel@vger.kernel.org
Subject: Re: speechless 2.5.69 kernel?
Message-ID: <20030521112115.GA3991@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Hadmut Danisch <hadmut@danisch.de>, Linux-Kernel@vger.kernel.org
References: <20030521103713.GA5863@danisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030521103713.GA5863@danisch.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 12:37:13PM +0200, Hadmut Danisch wrote:
 > could anyone give me a hint about booting a 2.5.69
 > kernel? (Please reply directly, I'm not on the list)
 > 
 > When booting the 2.5.69 the boot code prints 
 > "Uncompressing..." and "booting..." and then 
 > it remains completely silent. Since the hard disk
 > gets active, the kernel does not seem to have crashed,
 > but to have become speechless. (Standard x86 hardware)

First make sure your .config contains
CONFIG_INPUT=y, CONFIG_VT=y and CONFIG_VT_CONSOLE=y

if they do already, then.. if you have CONFIG_VIDEO_SELECT=y
try turning that off.

		Dave

