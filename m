Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261472AbSJTVN3>; Sun, 20 Oct 2002 17:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261489AbSJTVN3>; Sun, 20 Oct 2002 17:13:29 -0400
Received: from shells.hardanger.net ([209.113.172.35]:45320 "EHLO
	server.bohemians.org") by vger.kernel.org with ESMTP
	id <S261472AbSJTVN2>; Sun, 20 Oct 2002 17:13:28 -0400
Date: Sun, 20 Oct 2002 22:19:32 +0100
From: Martin Dahl <dahlm@izno.net>
To: linux-kernel@vger.kernel.org
Subject: Re: include/linux/pnp.h:248: parse error before ')' token
Message-ID: <20021020211931.GA11137@izno.net>
References: <20021020211420.GA10444@izno.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021020211420.GA10444@izno.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doh, forgot to say, this is with 2.5.44

> Got this when compiling parport_pc.c, looks like a typo in pnp.h
> 
> --- include/linux/pnp.h.orig    2002-10-20 22:08:38.000000000 +0100
> +++ include/linux/pnp.h 2002-10-20 22:08:49.000000000 +0100
> @@ -245,7 +245,7 @@
>  
>  /* just in case anyone decides to call these without PnP Support Enabled */
>  static inline int pnp_protocol_register(struct pnp_protocol *protocol) { return -ENODEV; }
> -static inline void pnp_protocol_unregister(struct pnp_protocol *protocol) { ; )
> +static inline void pnp_protocol_unregister(struct pnp_protocol *protocol) { ; }
>  static inline int pnp_init_device(struct pnp_dev *dev) { return -ENODEV; }
>  static inline int pnp_add_device(struct pnp_dev *dev) { return -ENODEV; }
>  static inline void pnp_remove_device(struct pnp_dev *dev) { ; }

-- 
Martin Dahl
dahlm@izno.net
