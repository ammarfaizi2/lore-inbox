Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264373AbVBDTzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbVBDTzc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 14:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVBDTyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 14:54:54 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:28666 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S266414AbVBDTyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 14:54:13 -0500
From: Hans-Peter Jansen <hpj@urpla.net>
To: Richard A Nelson <cowboy@cavein.org>
Subject: Re: [PATCH] Configure MTU via kernel DHCP
Date: Fri, 4 Feb 2005 20:54:02 +0100
User-Agent: KMail/1.5.4
Cc: Shane Hathaway <shane@hathawaymix.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200502022148.00045.shane@hathawaymix.org> <200502041755.41288.hpj@urpla.net> <Pine.LNX.4.58.0502041017560.30239@hygvzn-guhyr.pnirva.bet>
In-Reply-To: <Pine.LNX.4.58.0502041017560.30239@hygvzn-guhyr.pnirva.bet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502042054.02375.hpj@urpla.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:18d01dd0a2a377f0376b761557b5e99a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 February 2005 19:22, Richard A Nelson wrote:
>
> What will this code do at the (increasingly common) misconfigured
> sites - many places (hotels, airports, etc) return a MTU of 64...
> to which the DHCP3 client faithfully attempts to set, only to
> receive:
> 	SIOCSIFMTU: Invalid argument

Well, the ip auto configuration is mainly intended for diskless 
setups, not something, one will use in an uncontrolled environment.
I doubt, it will behave different, as well as usual distribution 
kernels will never enable this by default..

Pete

