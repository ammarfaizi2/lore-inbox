Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129116AbRCOXmq>; Thu, 15 Mar 2001 18:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129156AbRCOXmh>; Thu, 15 Mar 2001 18:42:37 -0500
Received: from smtp.Stanford.EDU ([171.64.14.23]:45034 "EHLO smtp.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S129116AbRCOXmZ>;
	Thu, 15 Mar 2001 18:42:25 -0500
Date: Thu, 15 Mar 2001 15:41:38 -0800
From: "Zack Weinberg" <zackw@Stanford.EDU>
To: Henrique de Moraes Holschuh <hmh@rcm.org.br>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: 2.2.19 pre13 doesn't like retransmitted SYN ACK packets
Message-ID: <20010315154138.A251@stanford.edu>
In-Reply-To: <20010315093116.B2523@stanford.edu> <20010315170947.C9124@godzillah>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010315170947.C9124@godzillah>; from hmh@rcm.org.br on Thu, Mar 15, 2001 at 05:09:47PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2001 at 05:09:47PM -0300, Henrique de Moraes Holschuh wrote:
> On Thu, 15 Mar 2001, Zack Weinberg wrote:
> > 2.2.19 pre13 sends an RST in response to a retransmitted SYN ACK which
> > arrives after we've sent out the final ACK of the handshake.  For
> > example:
> 
> Ah, that would explain the extremely crappy network conectivity I observed
> with 2.2.19preX, X < 17 (15 and 16 were better, but not as good as 17 or
> 2.2.18).  Please try 2.2.19pre17, it is handling itself just as well as
> 2.2.18 here.

2.2.19pre17 works.  Thank you.

zw
