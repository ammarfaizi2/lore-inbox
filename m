Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317750AbSFLRpl>; Wed, 12 Jun 2002 13:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317751AbSFLRpk>; Wed, 12 Jun 2002 13:45:40 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:39435 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S317750AbSFLRpj>; Wed, 12 Jun 2002 13:45:39 -0400
Date: Thu, 13 Jun 2002 03:45:32 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: kuznet@ms2.inr.ac.ru
cc: linux-kernel@vger.kernel.org
Subject: Re: Multicast netlink for non-root process
In-Reply-To: <200206121725.VAA16261@sex.inr.ac.ru>
Message-ID: <Mutt.LNX.4.44.0206130341160.1944-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2002 kuznet@ms2.inr.ac.ru wrote:

> But you seem to raise CAP_NET_ADMIN at each netlink_broadcast,
> so we do not get desired effect.

Yep, this version of the patch tried to preserve existing behaviour; any 
unnecesary cap_raise() calls can be removed as required.


- James
-- 
James Morris
<jmorris@intercode.com.au>


