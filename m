Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbTGALsi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 07:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTGALsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 07:48:38 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:46983 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S262267AbTGALsh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 07:48:37 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] patch-O1int-0306302317 for 2.5.73 interactivity
Date: Tue, 1 Jul 2003 22:04:47 +1000
User-Agent: KMail/1.5
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200307010029.19423.kernel@kolivas.org> <200307011931.24586.kernel@kolivas.org> <1057060831.603.6.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1057060831.603.6.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307012204.47605.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>On Tue, 2003-07-01 at 11:31, Con Kolivas wrote:
>> On Tue, 1 Jul 2003 18:59, Felipe Alfaro Solana wrote:
>> > I'm using 1000HZ. With respect to X, I haven't noticed any major
>> > difference. Should I? I haven't tested it under very heavy loads, but
>> > under normal workloads, it behaves a little better than its predecesors.
>>
>> I'd say it would depend on the graphic card. On a sis630 even with a p3
>> 1133 it is embarassingly jerky under even the slightest of loads without
>> my patch. However, it is as good now without the granularity patch as
>> earlier with the granularity.
>
>When I say "X feels jerky", I mean that I can notice the scheduler is
>not giving the X server enough CPU cycles (I mean, a continuous,
>smaller, but more frequent CPU timeslice) to perform window movement and
>redrawing fast enough to get ~25fps. Also, I don't think it's related to
>the video card. The combo patch I did with Mike's + Ingo's enhacements
>works beautifully for me.

Actually just the bastardised Ingo patch will do that on it's own. However 
that's never going to be incorporated.

Con
