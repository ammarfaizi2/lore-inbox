Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262380AbSLJPsz>; Tue, 10 Dec 2002 10:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262384AbSLJPsz>; Tue, 10 Dec 2002 10:48:55 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:35793 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S262380AbSLJPsy>; Tue, 10 Dec 2002 10:48:54 -0500
Date: Tue, 10 Dec 2002 16:56:32 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: James Morris <jmorris@intercode.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.2 networking, NET_BH latency
Message-ID: <20021210155632.GC23479@laguna.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	James Morris <jmorris@intercode.com.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021210153134.GB23479@laguna.alcove-fr> <Mutt.LNX.4.44.0212110245180.1678-100000@blackbird.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Mutt.LNX.4.44.0212110245180.1678-100000@blackbird.intercode.com.au>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 02:46:11AM +1100, James Morris wrote:

> On Tue, 10 Dec 2002, Stelian Pop wrote:
> 
> > I experience some odd behaviour when routing some network packets
> > on a 2.2(.18) kernel (with Ingo's low latency patch in case it 
> > matters).
> > 
> > Although there are probably bugs in the modifications we made
> > (a network card driver, some tweaks in the network core to deal
> > with several packet priorities etc), I'm not sure the behaviour
> > is directly due to a bug in our modifications or some synchronisation
> > issue we overlooked.
> 
> Can you reproduce the problem with a vanilla 2.2.23 kernel?

I didn't try yet, but it is on my list.

Should I interpret your message as some changes between 2.2.18 and 2.2.23
could be responsible for that behaviour or you are just shooting in the
dark ? :-)

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
