Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267602AbTBEAVR>; Tue, 4 Feb 2003 19:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267605AbTBEAVR>; Tue, 4 Feb 2003 19:21:17 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:63113 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S267602AbTBEAVR>;
	Tue, 4 Feb 2003 19:21:17 -0500
Date: Tue, 4 Feb 2003 19:32:56 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Art Haas <ahaas@airmail.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Trivial C99 patch for drivers/pnp/card.c
Message-ID: <20030204193256.GD22089@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Art Haas <ahaas@airmail.net>, linux-kernel@vger.kernel.org
References: <20030204214347.GA7235@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030204214347.GA7235@debian>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2003 at 03:43:47PM -0600, Art Haas wrote:
> Hi.
> 
> The following trivial patch switches this file to use C99 initializers.
> Please apply. Thanks.
> 
> Art Haas
> 
> ===== drivers/pnp/card.c 1.5 vs edited =====
> --- 1.5/drivers/pnp/card.c	Mon Jan 13 12:25:14 2003
> +++ edited/drivers/pnp/card.c	Tue Jan 14 10:34:42 2003
> @@ -43,8 +43,8 @@
>  }
>  
>  struct bus_type pnpc_bus_type = {
> -	name:	"pnp_card",
> -	match:	card_bus_match,
> +	.name	= "pnp_card",
> +	.match	= card_bus_match,
>  };
>  

Thanks, I'll send this out soon.

-Adam
