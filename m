Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291782AbSBHUYA>; Fri, 8 Feb 2002 15:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291785AbSBHUXw>; Fri, 8 Feb 2002 15:23:52 -0500
Received: from smtp3.cern.ch ([137.138.131.164]:56737 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S291782AbSBHUXj>;
	Fri, 8 Feb 2002 15:23:39 -0500
To: Tigran Aivazian <tigran@veritas.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] larger kernel stack (8k->16k) per task
In-Reply-To: <Pine.LNX.4.33.0202081645170.1359-100000@einstein.homenet>
From: Jes Sorensen <jes@sunsite.dk>
Date: 08 Feb 2002 21:22:05 +0100
In-Reply-To: Tigran Aivazian's message of "Fri, 8 Feb 2002 16:59:47 +0000 (GMT)"
Message-ID: <d3eljvlo5u.fsf@lxplus052.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian <tigran@veritas.com> writes:

> So, I found this patch useful at least for debugging. Moreover, I think it
> would be very useful to have it in Linus' kernel as a CONFIG_ option so
> that if people complain about random memory corruption then they can try
> to reproduce it with larger stack and then (with aid of /proc/stack) the
> offender is found and fixed. I cc'd Alan; if he thinks this is a bad idea
> I would be interested to know why.

Well as someone suggested, stick it under CONFIG_SLAB_DEBUG then, it
surely shouldn't be an option to be enabled in normal production
kernels but for debugging it's fine.

Jes
