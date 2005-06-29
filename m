Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262557AbVF2Ltg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262557AbVF2Ltg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 07:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbVF2Ltg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 07:49:36 -0400
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:30226 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S262557AbVF2Ltf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 07:49:35 -0400
To: Marat Buharov <marat.buharov@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swap partition vs swap file
References: <516d7fa80506281757188b2fda@mail.gmail.com>
	<20050628220334.66da4656.akpm@osdl.org>
	<698310e10506290337681fad81@mail.gmail.com>
From: Douglas McNaught <doug@mcnaught.org>
Date: Wed, 29 Jun 2005 07:46:34 -0400
In-Reply-To: <698310e10506290337681fad81@mail.gmail.com> (Marat Buharov's message of "Wed, 29 Jun 2005 14:37:56 +0400")
Message-ID: <m2wtod2xnp.fsf@Douglas-McNaughts-Powerbook.local>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marat Buharov <marat.buharov@gmail.com> writes:

> Hmm, but what about tells mkswap(8) tells:
> "...Note that a swap file must not contain any holes (so, using  cp
> (1) to create the file is not acceptable)..."?
>
> If swap file will be fragmented it will contain holes.

No, holes are actual missing blocks (which are read as zeros) while
fragmentation just means the blocks of the file are not contiguous on
disk.

-Doug
