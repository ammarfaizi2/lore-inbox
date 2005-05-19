Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVESWlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVESWlc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 18:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVESWlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 18:41:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:523 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261285AbVESWlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 18:41:31 -0400
Date: Thu, 19 May 2005 23:41:26 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Illegal use of reserved word in system.h
Message-ID: <20050519234126.A31656@flint.arm.linux.org.uk>
Mail-Followup-To: "J.A. Magallon" <jamagallon@able.es>,
	linux-kernel@vger.kernel.org
References: <20050518195337.GX5112@stusta.de> <6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com> <20050519112840.GE5112@stusta.de> <Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com> <1116505655.6027.45.camel@laptopd505.fenrus.org> <428CCD19.6030909@candelatech.com> <428CCE87.2010308@nortel.com> <428CCFA7.6010206@candelatech.com> <jeacmqg8ww.fsf@sykes.suse.de> <1116541832l.2940l.1l@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1116541832l.2940l.1l@werewolf.able.es>; from jamagallon@able.es on Thu, May 19, 2005 at 10:30:32PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2005 at 10:30:32PM +0000, J.A. Magallon wrote:
> Stupid and portable C++ code follows:
>...
> # ifdef __linux__
> 	strcpy(arch,"x86");

These two appear to be self-contradictory, unless you define "portable"
to mean "x86 only"... which would be hardly portable.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
