Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264860AbRFZVVs>; Tue, 26 Jun 2001 17:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264901AbRFZVVj>; Tue, 26 Jun 2001 17:21:39 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:6668 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S264860AbRFZVVZ>; Tue, 26 Jun 2001 17:21:25 -0400
Date: Tue, 26 Jun 2001 18:21:21 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Jason McMullan <jmcmullan@linuxcare.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: VM Requirement Document - v0.0
In-Reply-To: <20010626155838.A23098@jmcmullan.resilience.com>
Message-ID: <Pine.LNX.4.33L.0106261819400.23373-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2001, Jason McMullan wrote:

> 	If we take all the motivations from the above, and list
> them, we get:
>
> 	* Don't write to the (slow,packeted) devices until
> 	  you need to free up memory for processes.
> 	* Never cache reads from immediate/fast devices.
> 	* Keep packetized devices as continuously-idle as possible.
> 	  Small chunks of idleness don't count. You want to have
> 	  maximal stetches of idleness for the device.
> 	* Keep running processes as fully in memory as possible.

I agree with your modification, and with the obvious 4
points above ...

> 	* If we're getting low cache hit rates, don't flush
> 	  processes to swap.
> 	* If we're getting good cache hit rates, flush old, idle
> 	  processes to swap.

... but I fail to see this one. If we get a low cache hit
rate, couldn't that just mean we allocated too little memory
for the cache ?

I am very much interested in continuing this discussion...

Also, how would we translate all these requirements into
VM strategies ?

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

