Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318671AbSHAJQl>; Thu, 1 Aug 2002 05:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318677AbSHAJQl>; Thu, 1 Aug 2002 05:16:41 -0400
Received: from kf-zvb-fp02-013.dial.kabelfoon.nl ([62.45.19.13]:16136 "EHLO
	server.duranium.home") by vger.kernel.org with ESMTP
	id <S318671AbSHAJQk> convert rfc822-to-8bit; Thu, 1 Aug 2002 05:16:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nick Martens <nickm@kabelfoon.nl>
Reply-To: nickm@kabelfoon.nl
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.5.29 compile error [undefined reference to `register_serial']
Date: Thu, 1 Aug 2002 17:15:25 +0000
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200207311952.30547.nickm@kabelfoon.nl> <20020731205039.C18153@flint.arm.linux.org.uk>
In-Reply-To: <20020731205039.C18153@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208011715.25525.nickm@kabelfoon.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok thanks a lot

On Wednesday 31 July 2002 19:50, Russell King wrote:
> On Wed, Jul 31, 2002 at 07:52:30PM +0000, Nick Martens wrote:
> > I am trying to compile 2.5.29 but I am running into some compilation
> > problems i have attached my .config
>
> You need to enable:
> > #
> > # Serial drivers
> > #
> > # CONFIG_SERIAL_8250 is not set
>
> this option.
>
> (hmm, parport_serial is earlier in the config system; maybe we should
> suck it into drivers/serial so the config system works as expected?)

