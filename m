Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263440AbVBCUOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263440AbVBCUOw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 15:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263760AbVBCUOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 15:14:52 -0500
Received: from alephnull.demon.nl ([212.238.201.82]:54954 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S263219AbVBCUOR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 15:14:17 -0500
Date: Thu, 3 Feb 2005 21:14:08 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Lorenzo =?iso-8859-1?Q?Hern=E1ndez_Garc=EDa-Hierro?= 
	<lorenzo@gnu.org>,
       linux@horizon.com, mingo@elte.hu,
       Arjan van de Ven <arjan@infradead.org>, bunk@stusta.de,
       Chris Wright <chrisw@osdl.org>, davem@redhat.com,
       Hank Leininger <hlein@progressive-comp.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, Valdis.Kletnieks@vt.edu, spender@grsecurity.net
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
Message-ID: <20050203201408.GB3199@xi.wantstofly.org>
References: <20050202171702.24523.qmail@science.horizon.com> <1107365917.3754.155.camel@localhost.localdomain> <20050203115127.3245951f@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050203115127.3245951f@dxpl.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2005 at 11:51:27AM -0800, Stephen Hemminger wrote:

> Recent 2.6 does a more advanced form of port randomization already
> using address hash at connect time.  tcp_v4_get_port is only used for
> the case of applications that explicitly bind to port zero to find a
> free port.

Is any such randomisation done or planned for UDP?


--L
