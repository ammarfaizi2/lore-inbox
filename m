Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268496AbTCACBn>; Fri, 28 Feb 2003 21:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268497AbTCACBn>; Fri, 28 Feb 2003 21:01:43 -0500
Received: from a.smtp-out.sonic.net ([208.201.224.38]:41171 "HELO
	a.smtp-out.sonic.net") by vger.kernel.org with SMTP
	id <S268496AbTCACBm>; Fri, 28 Feb 2003 21:01:42 -0500
X-envelope-info: <dhinds@sonic.net>
Date: Fri, 28 Feb 2003 18:11:58 -0800
From: David Hinds <dhinds@sonic.net>
To: Thomas Molina <tmolina@cox.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hermes@gibson.dropbear.id.au, dahinds@users.sourceforge.net,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: 2.5.63 wireless loading problem
Message-ID: <20030228181158.A1745@sonic.net>
References: <Pine.LNX.4.44.0302281955380.2070-200000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302281955380.2070-200000@localhost.localdomain>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 07:59:47PM -0600, Thomas Molina wrote:

> # CONFIG_ISA is not set

The PCMCIA drivers decide whether or not ISA interrupts are available
based on CONFIG_ISA so you should turn this on.

Perhaps this is a misuse of this configuration option.  I'm not sure
what's the right thing to do.

-- Dave
