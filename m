Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129110AbRBNOzV>; Wed, 14 Feb 2001 09:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129055AbRBNOzM>; Wed, 14 Feb 2001 09:55:12 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:4341 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129110AbRBNOzD>; Wed, 14 Feb 2001 09:55:03 -0500
Date: Wed, 14 Feb 2001 11:13:38 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] network driver updates
Message-ID: <20010214111338.C7859@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3A8A7159.AF0E6180@colorfullife.com> <Pine.LNX.3.96.1010214055331.12910R-100000@mandrakesoft.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <Pine.LNX.3.96.1010214055331.12910R-100000@mandrakesoft.mandrakesoft.com>; from jgarzik@mandrakesoft.mandrakesoft.com on Wed, Feb 14, 2001 at 05:54:34AM -0600
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 14, 2001 at 05:54:34AM -0600, Jeff Garzik escreveu:
> On Wed, 14 Feb 2001, Manfred Spraul wrote:
> > * dev->mem_start: NULL means "not command line configuration" 0xffffffff
> > means "default".
> > several drivers only check for NULL, not for 0xffffffff.
> 
> netdev->mem_start is unsigned long... Should the test be for ~0 instead?
> The value 0xFFFFFFFF seems wrong for 64-bit machines.

I've added this to the Janitor's TODO List.

http://bazar.conectiva.com.br/~acme/TODO

- Arnaldo
