Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276399AbRJCPin>; Wed, 3 Oct 2001 11:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276400AbRJCPie>; Wed, 3 Oct 2001 11:38:34 -0400
Received: from hermes.toad.net ([162.33.130.251]:27112 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S276399AbRJCPi0>;
	Wed, 3 Oct 2001 11:38:26 -0400
Subject: Re: [PATCH] PnPBIOS additional fixes
To: linux-kernel@vger.kernel.org
Date: Wed, 3 Oct 2001 11:38:26 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20011003153826.D5BB35AC@thanatos.toad.net>
From: jdthood@home.dhs.org (Thomas Hood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop wrote:
>> Also, "lspnp -bv" should work and "lspnp -v" should fail.
>
>It doesn't:
>
># lspnp -v
>00 PNP0c02 bridge controller: ISA
>
>01 PNP0c01 memory controller: RAM

Well, it fails (gracefully) to report any resources, which
is what we expect.

-- 
Thomas Hood
(Don't reply to the From: address but to jdthood_AT_yahoo.co.uk)
