Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264616AbRFUBy2>; Wed, 20 Jun 2001 21:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264595AbRFUByS>; Wed, 20 Jun 2001 21:54:18 -0400
Received: from toscano.org ([64.50.191.142]:31944 "HELO bubba.toscano.org")
	by vger.kernel.org with SMTP id <S264591AbRFUByH>;
	Wed, 20 Jun 2001 21:54:07 -0400
Date: Wed, 20 Jun 2001 21:53:02 -0400
From: Pete Toscano <pete@toscano.org>
To: Ted Gervais <ve1drg@ve1drg.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ip_tables/ipchains
Message-ID: <20010620215302.A4636@bubba.toscano.org>
Mail-Followup-To: Pete Toscano <pete@toscano.org>,
	Ted Gervais <ve1drg@ve1drg.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0106200804160.2944-100000@ve1drg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0106200804160.2944-100000@ve1drg.com>; from ve1drg@ve1drg.com on Wed, Jun 20, 2001 at 08:05:41AM -0300
X-Unexpected: The Spanish Inquisition
X-Uptime: 9:52pm  up 10 min,  2 users,  load average: 1.10, 0.54, 0.24
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had a similar problem with this yesterday.  Try moving your .config
file to a safe place, making mrproper, then moving your .config back and
rebuilding.  I did this and all was well.

HTH,
pete

On Wed, 20 Jun 2001, Ted Gervais wrote:

> Wondering something..
> I ran insmod to bring up ip_tables.o and I received the following error:
> 
> /lib/modules/2.4.5/kernel/net/ipv4/netfilter/ip_tables.o: unresolved
> symbol nf_unregister_sockopt
> /lib/modules/2.4.5/kernel/net/ipv4/netfilter/ip_tables.o: unresolved
> symbol nf_register_sockopt
> 
> This is with kernel 2.4.5 and Slackware 7.1 is the distribution.
> Does anyone know what these unresolved symbols are about??
