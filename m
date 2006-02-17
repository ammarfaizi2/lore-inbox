Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWBQVwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWBQVwd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 16:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWBQVwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 16:52:32 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:12220
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1750971AbWBQVwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 16:52:32 -0500
Message-ID: <43F64598.2040809@microgate.com>
Date: Fri, 17 Feb 2006 15:52:24 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SIIG 8-port serial boards support
References: <20060124082538.GB4855@pazke> <20060124210140.GB23513@flint.arm.linux.org.uk> <20060202102644.GC5034@flint.arm.linux.org.uk> <20060202132726.GD24903@pazke> <20060202201734.GA17329@flint.arm.linux.org.uk> <20060203091308.GA19805@pazke> <20060203092435.GA30738@flint.arm.linux.org.uk> <20060217113942.GA30787@pazke> <20060217200213.GA13502@flint.arm.linux.org.uk> <43F63FD0.3060300@microgate.com> <20060217213903.GE13502@flint.arm.linux.org.uk>
In-Reply-To: <20060217213903.GE13502@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> What I suggest is to use CRTSCTS to enable the chosen flow control
> method.  Then we have a set of cflag bits which describe the flow
> control mode, eg CFLOWRS485, CFLOWMODEM, CFLOWALT (probably needs
> better names.)  CFLOWMODEM being the conventional mode should have
> an all zeros value.

That is better, as it enforces mutual exclusion of the different modes.

Thanks,
Paul

-- 
Paul Fulghum
Microgate Systems, Ltd.
