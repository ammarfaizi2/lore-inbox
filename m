Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264281AbTFDXMP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 19:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264292AbTFDXMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 19:12:15 -0400
Received: from air-2.osdl.org ([65.172.181.6]:24294 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264281AbTFDXMN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 19:12:13 -0400
Date: Wed, 4 Jun 2003 16:25:28 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: jgarzik@pobox.com, davem@redhat.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-bk+ broken networking
Message-Id: <20030604162528.637ae1ff.shemminger@osdl.org>
In-Reply-To: <20030604161437.2b4d3a79.shemminger@osdl.org>
References: <20030604161437.2b4d3a79.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jun 2003 16:14:37 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> Test machine running 2.5.70-bk latest can't boot because eth2 won't
> come up.  The same machine and configuration successfully brings up
> all the devices and runs on 2.5.70.
> 
> Starting ip6tables:  [  OK  ]
> Starting iptables:  [  OK  ]
> Setting network parameters:  [  OK  ]
> Bringing up loopback interface:  [  OK  ]
> Bringing up interface eth0:  [  OK  ]
> Bringing up interface eth1:  [  OK  ]
> Bringing up interface eth2:  sender address length == 0
> e1000 device does not seem to be present, delaying eth2 initialization.
> [FAILED]

One more piece of info:
eth0 and eth1 are e100
eth2 is e1000

