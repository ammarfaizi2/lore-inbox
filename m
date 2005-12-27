Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbVL0Gq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbVL0Gq5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 01:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbVL0Gq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 01:46:56 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:7652 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932247AbVL0Gq4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 01:46:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T7GDPsNC3onihWMf6lpNjKYpdEID5GpQqK+Orxx0Ri46wQg60HKguem652pFs0ns58Ht3u95hv0S9ddp+fNa1DxrLp9dwfR6L04hTPQCH4PIX8U1xkw+X6IOoi+CmYZPL8HXgcZw9lns1ezkC2CT/uNnOiyUleD30eegOaNIY6g=
Message-ID: <f0309ff0512262246q38f9f29l7e58a40c337ede75@mail.gmail.com>
Date: Tue, 27 Dec 2005 11:46:55 +0500
From: Nauman Tahir <nauman.tahir@gmail.com>
To: "Legend W." <mrwangxc@gmail.com>
Subject: Re: Machine Check Exception !
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <71a51c440512261852u593a2795y@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <71a51c440512261852u593a2795y@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/05, Legend W. <mrwangxc@gmail.com> wrote:
> Hello,
>
> I get the following message under 2.4.21 from RedHat:
>
> CPU 3: Machine Check Exception: 0000000000000004
> <Bank 0: b20000001040080f
>
> and the box is dead.
>
> When i use parsemce, it said:
> Status: (4) Machine Check in progress.
> Restart IP invalid.
> parsebank(0): b20000001040080f @ 3
>         External tag parity error
>         CPU state corrupt. Restart not possible
>         Error enabled in control register
>         Error not corrected.
>         Bus and interconnect error
>         Participation: Local processor originated request
>         Timeout: Request did not timeout
>         Request: Generic error
>         Transaction type : Invalid
>         Memory/IO : Other
>
> Can anybody please enlighten me what this means or what a possible
> problem behind might be?
>
> Thank you in advance
>
> PS: my box has dual Xeon 2.8G CPU

if you want to make your machine run any way use "nomce" at boot
prompt against your respective grub entry.

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
