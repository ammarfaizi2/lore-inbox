Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270856AbTGPKE5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 06:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270860AbTGPKE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 06:04:57 -0400
Received: from raq465.uk2net.com ([213.239.56.46]:24075 "EHLO
	mail.truemesh.com") by vger.kernel.org with ESMTP id S270856AbTGPKE4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 06:04:56 -0400
Date: Wed, 16 Jul 2003 11:13:21 +0100
From: Paul Nasrat <pauln@truemesh.com>
To: Il Skurko <a_very@mad.scientist.com>
Cc: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Subject: Re: Thinkpad T23: linux 2.5.x/2.6.0-test won't boot
Message-ID: <20030716101321.GD1141@raq465.uk2net.com>
Mail-Followup-To: Paul Nasrat <pauln@truemesh.com>,
	Il Skurko <a_very@mad.scientist.com>, linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk
References: <20030716100841.48619.qmail@mail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716100841.48619.qmail@mail.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 05:08:41AM -0500, Il Skurko wrote:
 
> After selecting the kernel in the grub menu,
> it only gets as far as to writing "Decompressing kernel...
> Booting kernel.". Then there is no more text
> output. The harddisk led indicates it continues
> with something though, but it does not respond
> to keyboard input (so I have to swith the computer
> off).

This is a known problem, I'd advise you to read the post-halloween doc
but Dave Jones seems to be rebuilding/upgrading codemonkey :)

The url should be:

http://www.codemonkey.org.uk/post-halloween-2.5.txt

Here is the appropriate snippet

Known gotchas.
~~~~~~~~~~~~~
Certain known bugs are being reported over and over. Here are the
workarounds.
- Blank screen after decompressing kernel?
  Make sure your .config has
  CONFIG_INPUT=y, CONFIG_VT=y, CONFIG_VGA_CONSOLE=y and
CONFIG_VT_CONSOLE=y

Paul
