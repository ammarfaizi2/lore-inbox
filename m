Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131781AbRCaAjl>; Fri, 30 Mar 2001 19:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131796AbRCaAjb>; Fri, 30 Mar 2001 19:39:31 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:48963 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S131781AbRCaAjR>; Fri, 30 Mar 2001 19:39:17 -0500
Date: Fri, 30 Mar 2001 18:38:34 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: "Manuel A. McLure" <mmt@unify.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: tulip (was RE: Kernel 2.4.3 fails to compile)
In-Reply-To: <419E5D46960FD211A2D5006008CAC79902E5C165@pcmailsrv1.sac.unify.com>
Message-ID: <Pine.LNX.3.96.1010330183646.2119E-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Mar 2001, Manuel A. McLure wrote:
> It looks like the tulip driver isn't as up-to-date as the one from
> 2.4.2-ac20 - when is 2.4.3-ac1 due? :-) I got NETDEV WATCHDOG errors shortly
> after rebooting with 2.4.3, although these were of the "slow/packet lossy"
> type I got with 2.4.2-ac20 instead of the "network completely unusable" type
> I got with 2.4.2-ac11 and earlier.

I'm betting that the latest ac (ac28?) is broken for you, too.

I had to revert the changes in 'ac' tulip -- they fixed Comet and 21041
cards, but broke some others.  sigh.

sigh.  More testing and debugging for Jeffro...  Comet (your chip, I
am guessing?) should be fixed ASAP, it's pretty easy.  21041 is not as
easy, but should be fixed quickly as well.

	Jeff



