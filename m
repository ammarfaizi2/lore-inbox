Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269473AbRHCQml>; Fri, 3 Aug 2001 12:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269472AbRHCQma>; Fri, 3 Aug 2001 12:42:30 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:33990 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S269466AbRHCQm3>; Fri, 3 Aug 2001 12:42:29 -0400
Date: Fri, 3 Aug 2001 09:40:07 -0700 (PDT)
From: Sridhar Samudrala <samudrala@us.ibm.com>
To: Alan Cox <alan@bagpuss.swansea.linux.org.uk>
cc: Sridhar Samudrala <samudrala@us.ibm.com>, jamal <hadi@cyberus.ca>,
        diffserv-general@lists.sourceforge.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        rusty@rustcorp.com.au, thiemo@sics.se,
        Renu Tewari <tewarir@us.ibm.com>, dmfreim@us.ibm.com
Subject: Re: [Linux Diffserv] Re: [PATCH] Inbound Connection Control mechanism:
In-Reply-To: <200107292127.f6TLRpC01583@bagpuss.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.21.0108030927080.26560-100000@w-sridhar2.des.sequent.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Jul 2001, Alan Cox wrote:

> > Our patch can be used along with SYN policing to prioritize incoming
> > connection requests on a socket. SYN policing can be used to limit 
> > the rate of a particular class, but it cannot be used to prioritize a 
> 
> No. Because you cant prove the packets are not spoofed. An attacker 
> becomes able to block classes

The aim of our patch is not to protect against a denial of service kind of
attack. It is more targeted towards a server that is getting overloaded
with valid connection requests. In such a scenario, this mechanism will 
provide better latency and connection rate for higher priority connections.

Thanks
Sridhar

