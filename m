Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271760AbRH0Phk>; Mon, 27 Aug 2001 11:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271758AbRH0Pha>; Mon, 27 Aug 2001 11:37:30 -0400
Received: from sweetums.bluetronic.net ([24.162.254.3]:43494 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S271761AbRH0PhO>; Mon, 27 Aug 2001 11:37:14 -0400
Date: Mon, 27 Aug 2001 11:37:13 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Casanova Robert <robert.casanova@grifols.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: "Machine Exception Check.... " with the last kernel?
In-Reply-To: <E15bJse-0003gG-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.33.0108271133260.23852-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2001, Alan Cox wrote:
>> someone know how to resolver the
>> "Machine Exception Check.... " with the last kernel?
>
>Machine Check Exception is a trap the processor takes when it finds itself
>internally inconsistent. Check the cooling, voltages and clock speeds are

Umm, that still doesn't address the question.  What good is it if there's
nothing to decode the damned numbers? (and it's not documented at all.)

>right. Its your CPU telling you it noticed things didnt seem happy.

... Or a compaq laptop signalling APM events.  2.4.9 locks up within
nanoseconds of beginning to activate MCE on my Compaq LTE5400 (P150.)
I have to turn it off to get the machine to boot ("nomce")

--Ricky


