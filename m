Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286959AbSCOJBc>; Fri, 15 Mar 2002 04:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287134AbSCOJBW>; Fri, 15 Mar 2002 04:01:22 -0500
Received: from dsl-213-023-038-002.arcor-ip.net ([213.23.38.2]:53679 "EHLO
	starship") by vger.kernel.org with ESMTP id <S286959AbSCOJBH>;
	Fri, 15 Mar 2002 04:01:07 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Benjamin LaHaise <bcrl@redhat.com>, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: [patch] ns83820 0.17 (Re: Broadcom 5700/5701 Gigabit Ethernet Adapters)
Date: Fri, 15 Mar 2002 09:56:11 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "David S. Miller" <davem@redhat.com>, whitney@math.berkeley.edu,
        rgooch@ras.ucalgary.ca, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
In-Reply-To: <200203110205.g2B25Ar05044@adsl-209-76-109-63.dsl.snfc21.pacbell.net> <3C90733B.4020205@mandrakesoft.com> <20020314153711.D9194@redhat.com>
In-Reply-To: <20020314153711.D9194@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16lnVU-0000VQ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 14, 2002 09:37 pm, Benjamin LaHaise wrote:
> > 4) Do you really mean to allocate memory for "REAL_RX_BUF_SIZE + 16"? 
> >  Why not plain old REAL_RX_BUF_SIZE?
> 
> The +16 is for alignment (just like the comment says).  The hardware 
> requires that rx buffers be 64 bit aligned.

Nit: that would be REAL_RX_BUF_SIZE + 15.

-- 
Daniel
