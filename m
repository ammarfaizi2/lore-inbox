Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278527AbRJXCIr>; Tue, 23 Oct 2001 22:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279163AbRJXCIh>; Tue, 23 Oct 2001 22:08:37 -0400
Received: from mail11.speakeasy.net ([216.254.0.211]:50957 "EHLO
	mail11.speakeasy.net") by vger.kernel.org with ESMTP
	id <S278529AbRJXCIV>; Tue, 23 Oct 2001 22:08:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: time tells all about kernel VM's
Date: Tue, 23 Oct 2001 22:08:55 -0400
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0110232141080.3690-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0110232141080.3690-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011024020830Z278529-17408+4201@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 October 2001 19:42, Rik van Riel wrote:
> On Mon, 22 Oct 2001, safemode wrote:
> > First the kernel created about 600MB of buffer in addition to the
> > application specified 128MB of buffer i had it using (e2defrag -p
> > 16384).  This brought the system to a crawl.
>
> Now that I think about it, and read the last message you wrote
> in the thread ... do you have some vmstat output during this
> time ?
>
> Do you know if e2defrag somehow locks buffers into RAM ?
>
e2defrag has a setting to allocate buffers.  According to the number i gave 
it, it should have allocated 128MB .. this is in accordance to what i 
observed in ps aux during the runtime.   All vmstat data i had was in buffer 
and lost when later i ran the graphviz programs and deadlocked the computer.  
I was not expecting to reboot.  I can always try it again.  e2defrag didn't 
deadlock the computer, but it did cause that unusual behavior that i observed 
just before deadlocking it with graphviz.   What kind of vmstat output do you 
want,   every 10 seconds?
