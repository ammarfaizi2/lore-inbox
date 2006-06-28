Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932730AbWF1GAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932730AbWF1GAg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 02:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932731AbWF1GAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 02:00:35 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:15283 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932730AbWF1GAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 02:00:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=c+aNcrlHvQTGtQzWsZyYcGdprzirzMkz70S6dRQ7uImwJHeURUF65EhmIBQ+x1owZSX0QG+0Pg4ZYJmkMdTDI1Pn9+Q0R8DSPcQzBpaxjaLTGiRs/ug7xEkSsKXlwoCZe03IpxPi0FVXSFicn+8kimjMiGhDx8gnw6eNiTh63vU=
Message-ID: <787b0d920606272300p46fae7e0n34ee8fa6e78b4fb3@mail.gmail.com>
Date: Wed, 28 Jun 2006 02:00:33 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: linux-kernel@vger.kernel.org, johnpol@2ka.mipt.ru, matthltc@us.ibm.com,
       guillaume.thouvenin@bull.net, michael.kerrisk@gmx.net,
       sekharan@us.ibm.com
Subject: Re: [RFC][PATCH 3/3] Process events biarch bug: New process events connector value
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Helsley writes:

> "Deprecate" existing Process Events connector interface
> and add a new one that works cleanly on biarch platforms.
>
> Any expansion of the previous event structure would break
> userspace's ability to workaround the biarch incompatibility
> problem. Hence this patch creates a new interface and generates
> events (for both when necessary).

I haven't yet seen a good explanation of what this is or does,
but I suspect it may be useful for the "top" program or for a
debugger. In either case, I am a highly interested party.
I maintain top as part of the procps package. People pay me to
hack on debuggers.

Mind pointing me to some documentation and an explanation of why
the feature was added? Is there a man page? (there should be)

Perhaps there is no need to support 32-bit apps using this on
64-bit systems. Obviously the 32-on-64 nonsense must include
full debugger support (else you can't work on it very well),
and I suppose there is a desire to support various proprietary
bits of junk like the Flash player, but... there is a place to
just draw the line.
