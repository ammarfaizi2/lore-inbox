Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270979AbTGVSTj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 14:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270981AbTGVSTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 14:19:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25612 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270979AbTGVSTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 14:19:38 -0400
Date: Tue, 22 Jul 2003 19:34:40 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Larry LeBlanc <leblanc@inmotiontechnology.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Power Management/PCMCIA conflict causes system freeze
Message-ID: <20030722193440.A16051@flint.arm.linux.org.uk>
Mail-Followup-To: Larry LeBlanc <leblanc@inmotiontechnology.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3F1D8159.4060209@inmotiontechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F1D8159.4060209@inmotiontechnology.com>; from leblanc@inmotiontechnology.com on Tue, Jul 22, 2003 at 11:24:25AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 11:24:25AM -0700, Larry LeBlanc wrote:
> Any ideas? I've tried turning on debug in apm but all that happens is 
> the debug messages freeze with the rest of the system. Is there any 
> other location I should turn on debug messages to try to get an idea of 
> where the system is hanging?

You need to enable sysrq, cause a hang, and then issue a sysrq-t and
sysrq-p to find out where you're hanging.

Note that if you're using a serial console, you need to hold the serial
port open for sysrq requests to be processed.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

