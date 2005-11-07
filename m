Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbVKGOxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbVKGOxb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 09:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbVKGOxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 09:53:31 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:48263 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750800AbVKGOxa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 09:53:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jR6ctrgzcc60oyDMln3AoPg8tEqZ0jCpanDDrfVuwmGB4SmNiFw76AfzFv2Z/IFO47c8tZpqM+xNJgFw65uYczKkFoi12hib6rP8vZQhpi6eHUGm8OsR8eGOVem3qhe7AZAFvPgYb0tadVWsBEUvZs+eue5NzwweXHZSatRH9vs=
Message-ID: <29495f1d0511070653w634784f7x51fcd62eebb386d7@mail.gmail.com>
Date: Mon, 7 Nov 2005 06:53:30 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Subject: Re: Comments on 2.6.10 schedule_timeout please
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <3AEC1E10243A314391FE9C01CD65429B13B2CE@mail.esn.co.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3AEC1E10243A314391FE9C01CD65429B13B2CE@mail.esn.co.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/05, Mukund JB. <mukundjb@esntechnologies.co.in> wrote:
>
> Dear Kernel Developers,
>
> I have noticed the schedule_timeout behaving somewhat different as penned
> from the Linux 2.6 Oreelly books.
> I have developed a SD card Driver for 2.6.10 kernel & it works fine.
> I needed a hardware reg to update that take a time of 300ms. I have issued a
> call like..
>
> set_current_state(TASK_INTERRUPTIBLE);
> schedule_timeout (300*HZ/1000);

Full code or function snippet, please.

> But, when I finally use it I get a sufficient delay which looks like a looped delay
> not allowing the keyboard to print messages on the screen.

This would be easier to diagnose if you shared all of the code you are
using *and* verified this occurred with a current kernel (2.6.10 is
old.).

Thanks,
Nish
