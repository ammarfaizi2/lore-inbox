Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269181AbTGJKXD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 06:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269183AbTGJKXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 06:23:02 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12045 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269181AbTGJKW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 06:22:59 -0400
Date: Thu, 10 Jul 2003 11:37:36 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Yang Yang <yangyang@juggler.ucsd.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCMCIA can't be probed during kernel loading????
Message-ID: <20030710113736.B1074@flint.arm.linux.org.uk>
Mail-Followup-To: Yang Yang <yangyang@juggler.ucsd.edu>,
	linux-kernel@vger.kernel.org
References: <20030710030648.GA5066@cannon.ucsd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030710030648.GA5066@cannon.ucsd.edu>; from yangyang@juggler.ucsd.edu on Wed, Jul 09, 2003 at 08:06:48PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 08:06:48PM -0700, Yang Yang wrote:
> 	I mean should the kernel be able to find the card itself and set it
> 	up , or does it need some user application ( like cardmgr ) to do it
> 	?

Correct.

>	if it's the latter case, basically means it's impossible to run a
> 	diskless station over NFS with only PCMCIA network card?

Also correct.  However, you could use an initial ramdisk and load cardmgr
from there, configure the interface and mount the real root filesystem
that way.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

