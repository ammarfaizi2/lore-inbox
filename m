Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272572AbTHKNHB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 09:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272573AbTHKNHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:07:01 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28936 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S272572AbTHKNG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:06:59 -0400
Date: Mon, 11 Aug 2003 14:06:56 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3-mm1: Oops when removing CardBus NIC from socket
Message-ID: <20030811140656.A24140@flint.arm.linux.org.uk>
Mail-Followup-To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <1060602635.610.7.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1060602635.610.7.camel@teapot.felipe-alfaro.com>; from felipe_alfaro@linuxmail.org on Mon, Aug 11, 2003 at 01:50:35PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 01:50:35PM +0200, Felipe Alfaro Solana wrote:
> I'm getting the following kernel oops when removing my 3Com 3CCFE575CT
> CardBus NIC from the CardBus socket:
> 
> kobject 'statistics' does not have a release() function, it is broken
> and must be fixed.
> Badness in kobject_cleanup at lib/kobject.c:402

This is a net driver problem, not a pcmcia problem.  Please direct it to
the appropriate net driver people (I believe akpm is the author of 3c59x.c
though.)  Thanks.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

