Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270620AbTHJSVJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 14:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270621AbTHJSVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 14:21:09 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4868 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270620AbTHJSVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 14:21:06 -0400
Date: Sun, 10 Aug 2003 16:33:50 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, kernelbugzilla@kuntnet.org
Subject: Re: [Bug 1068] New: Errors when loading airo module
Message-ID: <20030810163350.D32508@flint.arm.linux.org.uk>
Mail-Followup-To: "Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	kernelbugzilla@kuntnet.org
References: <51060000.1060524422@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <51060000.1060524422@[10.10.2.4]>; from mbligh@aracnet.com on Sun, Aug 10, 2003 at 07:07:02AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 07:07:02AM -0700, Martin J. Bligh wrote:
> http://bugme.osdl.org/show_bug.cgi?id=1068
> 
>            Summary: Errors when loading airo module
>     Kernel Version: 2.6.0-test3
>             Status: NEW
>           Severity: normal
>              Owner: rmk@arm.linux.org.uk
>          Submitter: kernelbugzilla@kuntnet.org

This needs to go to the airo maintainers, not me - the oops is caused
by buggy airo.c.

The IRQ problem is the result of bad configuration - you must enable
CONFIG_ISA if you're going to use non-Cardbus PCMCIA cards.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

