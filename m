Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268026AbTCACx0>; Fri, 28 Feb 2003 21:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268097AbTCACx0>; Fri, 28 Feb 2003 21:53:26 -0500
Received: from ip68-13-105-80.om.om.cox.net ([68.13.105.80]:64897 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S268026AbTCACxZ>; Fri, 28 Feb 2003 21:53:25 -0500
Date: Fri, 28 Feb 2003 21:03:39 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@localhost.localdomain
To: David Hinds <dhinds@sonic.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <hermes@gibson.dropbear.id.au>, <dahinds@users.sourceforge.net>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: 2.5.63 wireless loading problem
In-Reply-To: <20030228181158.A1745@sonic.net>
Message-ID: <Pine.LNX.4.44.0302282101550.2070-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2003, David Hinds wrote:

> On Fri, Feb 28, 2003 at 07:59:47PM -0600, Thomas Molina wrote:
> 
> > # CONFIG_ISA is not set
> 
> The PCMCIA drivers decide whether or not ISA interrupts are available
> based on CONFIG_ISA so you should turn this on.
> 
> Perhaps this is a misuse of this configuration option.  I'm not sure
> what's the right thing to do.

Your advice worked.  I now get eth0 up and dhcp works.  

IMHO it certainly violates the principle of least surprise.  I must have 
missed the documentation on this configuration advice.

