Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272458AbRIFLwm>; Thu, 6 Sep 2001 07:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272460AbRIFLwW>; Thu, 6 Sep 2001 07:52:22 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:58898 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S272458AbRIFLwV>;
	Thu, 6 Sep 2001 07:52:21 -0400
Date: Thu, 6 Sep 2001 08:52:18 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() on 2.4.9/10 issue
In-Reply-To: <20010904131401.A30296@cs.cmu.edu>
Message-ID: <Pine.LNX.4.33L.0109060851020.31200-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2001, Jan Harkes wrote:

> To get back on the thread I jumped into, I totally agree with Linus
> that writeout should be as soon as possible.

Nice way to destroy read performance.  As DaveM noted so
nicely in his reverse mapping patch (at the end of the
2.3 series), dirty pages get moved to the laundry list
and the washing machine will deal with them when we have
a full load.

Lets face it, spinning the washing machine is expensive
and running less than a full load makes things inefficient ;)

cheers,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

