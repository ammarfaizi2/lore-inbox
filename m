Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264618AbTEPXmz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 19:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264619AbTEPXmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 19:42:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49164 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264618AbTEPXmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 19:42:53 -0400
Date: Sat, 17 May 2003 00:55:38 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>,
       davej@suse.de
Subject: Re: 2.5.69-mm6: pccard oops while booting
Message-ID: <20030517005538.D26797@flint.arm.linux.org.uk>
Mail-Followup-To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
	Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>,
	davej@suse.de
References: <1053004615.586.2.camel@teapot.felipe-alfaro.com> <20030515144439.A31491@flint.arm.linux.org.uk> <1053037915.569.2.camel@teapot.felipe-alfaro.com> <20030515160015.5dfea63f.akpm@digeo.com> <1053090184.653.0.camel@teapot.felipe-alfaro.com> <1053110098.648.1.camel@teapot.felipe-alfaro.com> <20030516132908.62e54266.akpm@digeo.com> <1053121346.569.1.camel@teapot.felipe-alfaro.com> <3EC56173.1000306@gmx.net> <1053128425.607.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1053128425.607.1.camel@teapot.felipe-alfaro.com>; from felipe_alfaro@linuxmail.org on Sat, May 17, 2003 at 01:40:26AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 17, 2003 at 01:40:26AM +0200, Felipe Alfaro Solana wrote:
> This is getting tricky. How about this one?
> Attached is "ymfpci2.patch" with your suggested changes, and "dmesg"
> with the new oops info.

You need to reproduce the oops you get when you modprobe the module.
The oops with this driver built in is different, and akpm's changes
won't tell us which one causes the problem.

Instead of adding a character to each of those strings, could you
remove the 'Y' character so the strings remain the same length as
the original - that may cause the oops to reappear.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

