Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270728AbRHKGir>; Sat, 11 Aug 2001 02:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270729AbRHKGih>; Sat, 11 Aug 2001 02:38:37 -0400
Received: from demai05.mw.mediaone.net ([24.131.1.56]:23025 "EHLO
	demai05.mw.mediaone.net") by vger.kernel.org with ESMTP
	id <S270728AbRHKGiT>; Sat, 11 Aug 2001 02:38:19 -0400
Message-Id: <200108110638.f7B6cSh26238@demai05.mw.mediaone.net>
Content-Type: text/plain; charset=US-ASCII
From: Brian <hiryuu@envisiongames.net>
To: Nico Schottelius <nicos@pcsystems.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: multiply NULL pointer
Date: Sat, 11 Aug 2001 02:38:46 -0400
X-Mailer: KMail [version 1.3]
In-Reply-To: <3B72BA01.34D2A67F@pcsystems.de>
In-Reply-To: <3B72BA01.34D2A67F@pcsystems.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Run a few of those through ksymoops (see REPORTING-BUGS) so we can see 
where (in what function) the errors occurred and what functions led to 
that call.

I'm curious if the issues are related to the oops messages I'm getting on 
our web server.

	-- Brian

On Thursday 09 August 2001 12:27 pm, Nico Schottelius wrote:
> Hello!
>
> Running a p2 400 mhz box with a 3com 3c905, with
> _very_ heavy nfs traffic and disc io the following NULL
> pointers were produced. I attached the whole dmesg output.
> If more informations are needed, I will send them.
>
> After every NULL pointer printed on the console
> I took a new dmesg, so the one with the highest number
> should be relevant.
>
> The file PSAUX_DMESG2 shows what was still living after
> DMESG2.
>
> Sincerly,
>
> Nico
