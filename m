Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279502AbRKIGad>; Fri, 9 Nov 2001 01:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279506AbRKIGaX>; Fri, 9 Nov 2001 01:30:23 -0500
Received: from zero.tech9.net ([209.61.188.187]:6161 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S279502AbRKIGaM>;
	Fri, 9 Nov 2001 01:30:12 -0500
Subject: Re: Question about kernel VM
From: Robert Love <rml@tech9.net>
To: Louis Garcia <louisg00@bellsouth.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1005287035.19248.7.camel@tiger>
In-Reply-To: <1005287035.19248.7.camel@tiger>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.07.16.47 (Preview Release)
Date: 09 Nov 2001 01:30:31 -0500
Message-Id: <1005287432.808.6.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-11-09 at 01:23, Louis Garcia wrote:
> Do all ports of the kernel, like ix86, ia64, sparc, alpha, and ppc,
> share one VM subsystem or do each port have their own???

They share the same VM, located in mm/

There is arch-dependent VM code, in arch/<arch>/mm, but that is mostly
support for specific memory functions like initializing the address
space.

	Robert Love



