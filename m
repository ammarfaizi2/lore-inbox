Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274830AbRIUU6A>; Fri, 21 Sep 2001 16:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274832AbRIUU5u>; Fri, 21 Sep 2001 16:57:50 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:9481 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S274830AbRIUU5d>;
	Fri, 21 Sep 2001 16:57:33 -0400
Date: Fri, 21 Sep 2001 17:57:36 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: "Marc A. Lehmann" <pcg@goof.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Significant performace improvements on reiserfs systems,
 kupdated bugfixes
In-Reply-To: <20010921221225.A22402@schmorp.de>
Message-ID: <Pine.LNX.4.33L.0109211757050.19147-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2001, Marc A. Lehmann wrote:

> A contiguous write doesn't cost anything much, so it could be major
> win if the kernel could flush dirty buffers that are behind and after
> the dirty block to be written. But this would nicely conflict with
> allocate-on-flush ;)

On the contrary, when you have a bunch of small files to sync
you just allocate them next to each other and flush them all
at once ;)

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

