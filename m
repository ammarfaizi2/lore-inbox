Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289066AbSAFVKl>; Sun, 6 Jan 2002 16:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289035AbSAFVJm>; Sun, 6 Jan 2002 16:09:42 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:34829 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289033AbSAFVJb>;
	Sun, 6 Jan 2002 16:09:31 -0500
Date: Sun, 6 Jan 2002 19:09:11 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: <linux-kernel@vger.kernel.org>, <mjc@kernel.org>, <bcrl@redhat.com>
Subject: Re: hashed waitqueues
In-Reply-To: <20020104094049.A10326@holomorphy.com>
Message-ID: <Pine.LNX.4.33L.0201061906260.872-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, William Lee Irwin III wrote:

> This is a long-discussed space optimization for the VM system, with
> what is expected to be a minor time tradeoff.

Actually, I don't expect the mentioned time tradeoff to be
anywhere near measurable. When we wait on a page we go through
the scheduler, context switches, etc...

I'll definately apply this patch and am looking forward to the
results from the ODSL test you have queued.

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/


