Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262276AbVENKQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbVENKQL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 06:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbVENKQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 06:16:11 -0400
Received: from rly-ip04.mx.aol.com ([64.12.138.8]:21890 "EHLO
	rly-ip04.mx.aol.com") by vger.kernel.org with ESMTP id S262276AbVENKQG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 06:16:06 -0400
Message-ID: <4285D4E9.9090208@yahoo.co.uk>
Date: Sat, 14 May 2005 11:37:29 +0100
From: christos gentsis <christos_gentsis@yahoo.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jnf <jnf@innocence-lost.us>
CC: linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: Y2K-like bug to hit Linux computers! - Info of the day
References: <4EE0CBA31942E547B99B3D4BFAB348114BED13@mail.esn.co.in> <200505131522.32403.vda@ilport.com.ua> <Pine.LNX.4.61.0505130825310.4428@chaos.analogic.com> <Pine.LNX.4.61.0505130837390.4781@chaos.analogic.com>            <42850FC7.7010603@tmr.com> <200505132047.j4DKlcgV025923@turing-police.cc.vt.edu> <4285C030.1080706@yahoo.co.uk> <Pine.LNX.4.62.0505140240250.14650@fhozvffvba.vaabprapr-ybfg.arg>
In-Reply-To: <Pine.LNX.4.62.0505140240250.14650@fhozvffvba.vaabprapr-ybfg.arg>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AOL-IP: 195.93.24.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jnf wrote:

>submission$ cat test.c
>int main(void) {
>        signed short int count = 0;
>
>        while(count >= 0 ) {
>                printf("count: %d\n", count++ );
>        }
>        printf("count: %d\n");
>}
>submission$ gcc -o test test.c
>submission$ ./test
>[...]
>count: 32767
>count: -1
>
>  
>
correct but i didn't mean that... i mean how to become negative with out
an overflow...

>I could be wrong here, but I don't think the hardware even keeps track of
>the clock ticks, rather it just ticks and lets the software keep track.
>
>  
>
it has to have hardware because if there is not so how the time is
updated then the system is turned off? ;)
it has to be hardware that keeps working...


