Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313153AbSDDMFW>; Thu, 4 Apr 2002 07:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313152AbSDDMFM>; Thu, 4 Apr 2002 07:05:12 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:58908 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S313155AbSDDMFE>;
	Thu, 4 Apr 2002 07:05:04 -0500
Date: Thu, 4 Apr 2002 13:01:47 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: <tigran@einstein.homenet>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Keith Owens <kaos@ocs.com.au>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>,
        Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
        Ingo Molnar <mingo@redhat.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <E16t5oc-0005kr-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0204041245340.1475-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2002, Alan Cox wrote:
> > exported only "internally". But that is their own problem -- we should
> > neither help them nor prevent them from doing their work and earning their
>
> So why are you trying to put me out of business by allowing people to use
> my code in ways the GPL doesn't permit. That cuts both ways.

That would be the case _only_ under yet another interpretation of GPL.
Strange thing about GPL is that there are so many interpretations to
choose from :)

It is your interpretation that matters, not mine, so how can I convince
you? But I am entitled to an opinion that your interpretation is, in some
sense, wrong. Namely, in the sense that it is inconsistent with the
similar situation in the case of libraries or even system calls. I don't
see why exporting kernel symbols should be so radically different and
extremely sensitive to the nature of the consumer's license for some
symbols but not for others...

Regards,
Tigran

