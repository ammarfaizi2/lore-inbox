Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280587AbRKFVqP>; Tue, 6 Nov 2001 16:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280603AbRKFVqB>; Tue, 6 Nov 2001 16:46:01 -0500
Received: from cc78409-a.hnglo1.ov.nl.home.com ([212.120.97.185]:49286 "EHLO
	dexter.hensema.xs4all.nl") by vger.kernel.org with ESMTP
	id <S280601AbRKFVpW>; Tue, 6 Nov 2001 16:45:22 -0500
From: spamtrap@use.reply-to (Erik Hensema)
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
Date: 6 Nov 2001 21:45:20 GMT
Message-ID: <slrn9ugmfg.eul.spamtrap@dexter.hensema.xs4all.nl>
In-Reply-To: <Pine.LNX.4.33L.0111061921240.27028-100000@duckman.distro.conectiva>
Reply-To: erik@hensema.net
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel (riel@conectiva.com.br) wrote:
>On 6 Nov 2001, Erik Hensema wrote:
>
>> >1)  IT SHOULD NOT BE PRETTY.  No tabs to line up columns.  No "progress
>> >bars."  No labels except as "proc comments" (see later).  No in-line labelling.
>>
>> It should not be pretty TO HUMANS. Slight difference. It should
>> be pretty to shellscripts and other applications though.
>
>I really fail to see your point, it's trivial to make
>files which are easy to read by humans and also very
>easy to parse by shellscripts.

Right, let me rephrase myself. There's no real need for /proc to be pretty
to humans, though it would be nice. Readability by applications should be
the priority though.

>PROCESSOR=0
>VENDOR_ID=GenuineIntel
>CPU_FAMILY=6
>MODEL=6
>MODEL_NAME="Celeron (Mendocino)"

Nice, it could work. However, the kernel does impose policy in this case
(variable naming policy, that is). But it's a nice compromise between
readability by humans and readability by programs.

-- 
Erik Hensema (erik@hensema.net)
I'm on the list, no need to Cc: me, though I appreciate one if your
mailer doesn't support the References header.
