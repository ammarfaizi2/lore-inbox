Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265670AbRF1Mnv>; Thu, 28 Jun 2001 08:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265673AbRF1Mnl>; Thu, 28 Jun 2001 08:43:41 -0400
Received: from ns.suse.de ([213.95.15.193]:46860 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S265670AbRF1Mnb>;
	Thu, 28 Jun 2001 08:43:31 -0400
To: Gautier Harmel <Gautier.Harmel@qosmos.net>
Subject: Re: How to pass packets up to protocols layer ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B3AFFDE.2763D18F@qosmos.net.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 28 Jun 2001 14:42:11 +0200
In-Reply-To: Gautier Harmel's message of "28 Jun 2001 11:58:19 +0200"
Message-ID: <oup3d8k4vz0.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Either use netif_rx()/ for complete packets that should go through the
whole stack again or nf_reinject() from your hook.

-Andi
