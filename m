Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270995AbTHFUx7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 16:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271751AbTHFUx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 16:53:59 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42762 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270995AbTHFUx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 16:53:58 -0400
Date: Wed, 6 Aug 2003 21:53:54 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Adam Belay <ambx1@neo.rr.com>, torvalds@osdl.org, misha@nasledov.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5/2.6 PCMCIA Issues
Message-ID: <20030806215354.G16116@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Adam Belay <ambx1@neo.rr.com>, torvalds@osdl.org,
	misha@nasledov.com, linux-kernel@vger.kernel.org
References: <20030804232204.GA21763@nasledov.com> <20030805144453.A8914@flint.arm.linux.org.uk> <20030806045627.GA1625@nasledov.com> <200308060559.h765xhI05860@mail.osdl.org> <20030806114225.GI13275@neo.rr.com> <20030806133450.31da90e4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030806133450.31da90e4.akpm@osdl.org>; from akpm@osdl.org on Wed, Aug 06, 2003 at 01:34:50PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 01:34:50PM -0700, Andrew Morton wrote:
> Adam Belay <ambx1@neo.rr.com> wrote:
> >
> > [PCMCIA] Fix PnP Probing in i82365.c
> >  pnp_x_valid returns 1 if valid.  Therefore we should be using !pnp_port_valid.
> >  Also cleans up some formatting issues.
> 
> This patch fixes the insertion-time hang on the A21P, with CONFIG_I82365=y

Ok, I'll merge that now.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

