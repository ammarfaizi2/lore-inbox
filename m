Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275197AbRIZNws>; Wed, 26 Sep 2001 09:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275201AbRIZNwi>; Wed, 26 Sep 2001 09:52:38 -0400
Received: from [200.250.64.5] ([200.250.64.5]:53514 "EHLO nat.brsat.com.br")
	by vger.kernel.org with ESMTP id <S275197AbRIZNwY>;
	Wed, 26 Sep 2001 09:52:24 -0400
Message-ID: <3BB1DE02.8010704@brsat.com.br>
Date: Wed, 26 Sep 2001 10:54:10 -0300
From: Roberto Orenstein <roberto@brsat.com.br>
Reply-To: roberto@brsat.com.br
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.9-ac15 i686; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: pt-br, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  2.4.9-ac15 painfully sluggish
In-Reply-To: <Pine.LNX.4.33L.0109251628460.26091-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

> On Tue, 25 Sep 2001, Pau Aliagas wrote:
> 
> 
>> The problem seems to be related in pages not moved to swap but
>> being discarded somehow and reread later on.... just a guess.
> 
> 
> I've made a small patch to 2.4.9-ac15 which should make
> page_launder() smoother, make some (very minor) tweaks
> to page aging and updates various comments in vmscan.c
> 
> It's below this email and at:
> 
> http://www.surriel.com/patches/2.4/2.4.9-ac15-age+launder
> 
> Since I failed to break 2.4.9-ac15 with this patch following
> the instructions given to me by others, it would be nice to
> know if the thing can still break on your machines.
> 
> Please test,
> 

Test done, and it seems just fine.
The problem vanish away. Didn't trigger anymore, on my machine.

thanx

Roberto

