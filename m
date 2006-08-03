Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbWHCPnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWHCPnf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 11:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbWHCPnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 11:43:35 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:57234 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S964814AbWHCPnd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 11:43:33 -0400
Date: Thu, 3 Aug 2006 19:43:09 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Arnd Hannemann <arnd@arndnet.de>
Cc: Krzysztof Oledzki <olel@ans.pl>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: problems with e1000 and jumboframes
Message-ID: <20060803154309.GB9745@2ka.mipt.ru>
References: <44D1FEB7.2050703@arndnet.de> <20060803135925.GA28348@2ka.mipt.ru> <44D20A2F.3090005@arndnet.de> <20060803150330.GB12915@2ka.mipt.ru> <Pine.LNX.4.64.0608031705560.8443@bizon.gios.gov.pl> <20060803151631.GA14774@2ka.mipt.ru> <44D21845.6020703@arndnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <44D21845.6020703@arndnet.de>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 03 Aug 2006 19:43:11 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 05:37:41PM +0200, Arnd Hannemann (arnd@arndnet.de) wrote:
> > It can be.
> > Could attached  (completely untested) patch help?
> 
> I will try this in a minute. However is there any way to see which
> allocation e1000 does without triggering allocation failures? ;-)

One can add a printk at the end of e1000_change_mtu() and dump
adapter->rx_buffer_len + NET_IP_ALIGN there.

> Thanks,
> Arnd Hannemann

-- 
	Evgeniy Polyakov
