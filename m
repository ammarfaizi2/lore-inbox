Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWEWQn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWEWQn3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 12:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWEWQn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 12:43:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3787 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932081AbWEWQn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 12:43:28 -0400
Date: Tue, 23 May 2006 09:43:24 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Herman Elfrink <herman.elfrink@ti-wmc.nl>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] FLAME: external kernel module for L2.5 meshing
Message-ID: <20060523094324.11926fcc@localhost.localdomain>
In-Reply-To: <44731733.7000204@ti-wmc.nl>
References: <44731733.7000204@ti-wmc.nl>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.1.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2006 16:07:47 +0200
Herman Elfrink <herman.elfrink@ti-wmc.nl> wrote:

>  
> FLAME stands for "Forwarding Layer for Meshing"
> 
> FLAME provides an intermediate layer between the network layer (e.g. 
> IPv4/IPv6) and the link (MAC) layer, providing L2.5 meshing. Both 
> network layer and MAC layer can be used unchanged: to the network layer 
> FLAME appears as a normal Ethernet-type MAC layer, and the underlying 
> `real' MAC layer will see it as just another type of network layer.
> 

Didn't you just reinvent 802.1d bridging? and/or WDS?

As far as the Ethernet protocol field. Getting a real assigned number
would have to come out of the IEEE 802. 

You would need
	http://standards.ieee.org/regauth/ethertype/forms/index.html

It is cheaper (free vs $2500) to get a LLC sap assigned, but then
you would have to change the protocol.
	http://standards.ieee.org/regauth/llc/index.html
