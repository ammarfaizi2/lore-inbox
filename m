Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270721AbRIFNXt>; Thu, 6 Sep 2001 09:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270712AbRIFNXj>; Thu, 6 Sep 2001 09:23:39 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:29449 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S270661AbRIFNXd>;
	Thu, 6 Sep 2001 09:23:33 -0400
Date: Thu, 6 Sep 2001 10:23:39 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Kurt Garloff <garloff@suse.de>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() on 2.4.9/10 issue
In-Reply-To: <20010906151827.F21793@gum01m.etpnet.phys.tue.nl>
Message-ID: <Pine.LNX.4.33L.0109061021090.31200-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2001, Kurt Garloff wrote:

> > Exactly, so we need to give the queue some time to load
> > up, right ?
>
> Just use two limits:
> * Time: After some time (say two seconds), we can always afford to write it
>   out
> * Queue filling: After it has a certain size, it's worth doing a writing.

Sounds good to me.

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

