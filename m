Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275078AbRIYQZc>; Tue, 25 Sep 2001 12:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275079AbRIYQZW>; Tue, 25 Sep 2001 12:25:22 -0400
Received: from [213.97.45.174] ([213.97.45.174]:43012 "EHLO pau.intranet.ct")
	by vger.kernel.org with ESMTP id <S275078AbRIYQZK>;
	Tue, 25 Sep 2001 12:25:10 -0400
Date: Tue, 25 Sep 2001 18:25:18 +0200 (CEST)
From: Pau Aliagas <linux4u@wanadoo.es>
X-X-Sender: <pau@pau.intranet.ct>
To: Rik van Riel <riel@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.9-ac15 painfully sluggish
In-Reply-To: <Pine.LNX.4.33L.0109251315130.26091-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0109251819520.1401-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2001, Rik van Riel wrote:

> Could you give me some info on how much memory is being
> used by the various caches (first lines of top) and maybe
> a few lines of vmstat output ?

Only setiathome was really running whilst the rest of processes just where
in D state; the IDE disk never seemed to stop.

Once I stopped the CPU hog (that's seti) kapm-idled ained the CPU, but
again the swap was not being used but for a few Kb (about 2M maximum).

The problem seems to be related in pages not moved to swap but being
discarded somehow and reread later on.... just a guess.

If you need any debugging just tell me what and I'll give it a try.

Pau

