Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269326AbRIRMJv>; Tue, 18 Sep 2001 08:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269413AbRIRMJl>; Tue, 18 Sep 2001 08:09:41 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:54792 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S269326AbRIRMJc>;
	Tue, 18 Sep 2001 08:09:32 -0400
Date: Tue, 18 Sep 2001 09:09:04 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>, <linux-kernel@vger.kernel.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <Pine.LNX.4.33.0109171010280.8961-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0109180906530.14288-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2001, Linus Torvalds wrote:

> Well, here's a 10-line patch to make the anonymous pages get on the LRU
> queues, and thus get aged along with all the others.

The problem is that they will still get aged DOWN all
the time, even if they are accessed continuously by
the process which owns the page....

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

