Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271518AbRIFR1h>; Thu, 6 Sep 2001 13:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271522AbRIFR11>; Thu, 6 Sep 2001 13:27:27 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:6665 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271518AbRIFR1U>; Thu, 6 Sep 2001 13:27:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: page_launder() on 2.4.9/10 issue
Date: Thu, 6 Sep 2001 19:34:41 +0200
X-Mailer: KMail [version 1.3.1]
Cc: riel@conectiva.com.br, jaharkes@cs.cmu.edu, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
In-Reply-To: <20010906171049.4d40da02.skraw@ithnet.com> <598996561.999793086@[10.132.112.53]>
In-Reply-To: <598996561.999793086@[10.132.112.53]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010906172741Z16140-26183+20@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 6, 2001 05:18 pm, Alex Bligh - linux-kernel wrote:
> --On Thursday, September 06, 2001 5:10 PM +0200 Stephan von Krawczynski 
> <skraw@ithnet.com> wrote:
> 
> > (or default = 1024) gives such a ridicolously bad
> > performance
> 
> I know. I am trying to ensure we have the problem definitively
> identified, either from /proc/memareas, or by showing it
> goes away if you change rsize/wsize. I am NOT proposing
> it as a fix.

Are rsize/wsize expressed in bytes?  In which case you'd want them to be 4096 
for this test.

--
Daniel
