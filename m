Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271607AbRHUSsA>; Tue, 21 Aug 2001 14:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271819AbRHUSru>; Tue, 21 Aug 2001 14:47:50 -0400
Received: from pc3-oxfo3-0-cust1.oxf.cable.ntl.com ([213.107.68.1]:62218 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S271815AbRHUSra>;
	Tue, 21 Aug 2001 14:47:30 -0400
Date: Tue, 21 Aug 2001 19:47:05 +0100
From: Ian Lynagh <igloo@earth.li>
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with corruption sending packets from a module
Message-ID: <20010821194705.A8569@stu163.keble.ox.ac.uk>
In-Reply-To: <20010820170424.A713@stu163.keble.ox.ac.uk> <200108202257.CAA00748@mops.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <200108202257.CAA00748@mops.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Tue, Aug 21, 2001 at 02:57:08AM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2001 at 02:57:08AM +0400, Alexey Kuznetsov wrote:
> Hello!
> 
> > In case someone is reading the archives and has a similar problem, this
> > appears to be the cause of the trouble. If I do
> > skb->data += sizeof(struct ethhdr);
> > then it's fine. 
> 
> It is not fine at all... You are not allowed to change skb->data,
> skb->len etc.

Sorry, yes, I meant "it works" which isn't quite the same thing  :-)


Ian, struggling against a lack of decent documentation but slowly
getting there, I think!

