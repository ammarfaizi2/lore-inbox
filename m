Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273992AbRIXQgK>; Mon, 24 Sep 2001 12:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273996AbRIXQf4>; Mon, 24 Sep 2001 12:35:56 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:45330 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273992AbRIXQfu>; Mon, 24 Sep 2001 12:35:50 -0400
Date: Mon, 24 Sep 2001 12:12:53 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Paul Larson <plars@austin.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: __alloc_pages: 0-order allocation failed
In-Reply-To: <1001331342.4610.49.camel@plars.austin.ibm.com>
Message-ID: <Pine.LNX.4.21.0109241212140.1593-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 24 Sep 2001, Paul Larson wrote:

> 
> The patch helped for me, but there are still problems.  I was able to
> run all the way through LTP without it shutting anything down.  When I
> used one of the memory tests to chew up all the ram though, I noticed
> that VM was killing things it shouldn't have.  First thing to get killed
> was cron, then top, then it finally killed mtest01 (the memory test
> mentioned before).

Ok, its good to know that the patch at least helped.

Watch out for another patch in hours.

