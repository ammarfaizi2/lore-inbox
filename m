Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290505AbSAQWly>; Thu, 17 Jan 2002 17:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290511AbSAQWlf>; Thu, 17 Jan 2002 17:41:35 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:29087 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S290505AbSAQWla>; Thu, 17 Jan 2002 17:41:30 -0500
Date: Thu, 17 Jan 2002 23:41:03 +0100
From: Andi Kleen <ak@muc.de>
To: Mark Frazer <mark@somanetworks.com>
Cc: davem@redhat.com, ak@muc.de, kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] new sysctl net/ipv4/ip_default_bind
Message-ID: <20020117234103.A2797@averell>
In-Reply-To: <20020117172713.A1893@somanetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20020117172713.A1893@somanetworks.com>; from mark@somanetworks.com on Thu, Jan 17, 2002 at 11:27:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2002 at 11:27:13PM +0100, Mark Frazer wrote:
> The following patch applies against 2.4.17 and creates a new sysctl
> node /proc/sys/net/ipv4/ip_default_bind.  The purpose of the control
> is to allow a default IP address to be selected by the sysadmin for
> outgoing connections.  That is, for sockets which do not bind(2) the
> local end of the socket before calling connect(2).

You can already do that using the 'from' attribute in iproute2
aka prefered source address per route. Just set it for your default
route.

-Andi
