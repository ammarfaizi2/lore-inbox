Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285097AbRLFKXZ>; Thu, 6 Dec 2001 05:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285100AbRLFKXP>; Thu, 6 Dec 2001 05:23:15 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:41491 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S285097AbRLFKW6>; Thu, 6 Dec 2001 05:22:58 -0500
Date: Thu, 6 Dec 2001 05:22:29 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: dwmw2@infradead.org, jgarzik@mandrakesoft.com, kaos@ocs.com.au,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.16 for pointers to __devexit functions
Message-ID: <20011206052229.H4087@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <11777.1007619756@kao2.melbourne.sgi.com> <3C0F27CA.59C22DEF@mandrakesoft.com> <15133.1007631619@redhat.com> <20011206.021534.66178457.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011206.021534.66178457.davem@redhat.com>; from davem@redhat.com on Thu, Dec 06, 2001 at 02:15:34AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 02:15:34AM -0800, David S. Miller wrote:
>    From: David Woodhouse <dwmw2@infradead.org>
>    Date: Thu, 06 Dec 2001 09:40:19 +0000
>    
>    Doesn't work at all, or just doesn't work with the (current) minimum
>    recommended compiler? We have to increase those minima at some point. 
> 
> The "golden" sparc64 compiler has been in use for years and is what
> has the weak problem, and updating it would be a major pain in the
> butt.

Note that gcc-2.96-RH (particularly 2.96-101) is not that far off from being
usable on sparc64 AFAIK (there is just one miscompilation in ext2_statfs
I'm aware of which I've submitted fix for review yesterday), of course
further testing may prove otherwise.

	Jakub
