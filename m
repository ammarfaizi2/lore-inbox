Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbTEMPve (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbTEMPvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:51:18 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49682 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261706AbTEMPuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:50:05 -0400
Date: Tue, 13 May 2003 17:00:29 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ian Molton <spyro@f2s.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ARM26 [NEW ARCHITECTURE]
Message-ID: <20030513170029.B15172@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Ian Molton <spyro@f2s.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030513153315.73679a38.spyro@f2s.com> <1052835818.431.37.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1052835818.431.37.camel@dhcp22.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Tue, May 13, 2003 at 03:23:39PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 03:23:39PM +0100, Alan Cox wrote:
> I guess its no crazier than the MacII port. What does Russell think
> about it however and also is this 2.4 or 2.5 targetted ?

I'm fine with it; I'd rather someone else (who has more interest
in the machines) picked it up.

The basic idea is to rip out the arm26 code from arch/arm and
include/asm-arm, thereby allowing include/asm-arm/proc-armv to
be collapsed into include/asm-arm, removing some clutter.

Separating it out should also allow arm26 to shrink down to
something smaller, which is fairly critical for these machines.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

