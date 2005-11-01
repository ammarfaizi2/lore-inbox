Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbVKATyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbVKATyr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 14:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbVKATyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 14:54:47 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:39903 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751230AbVKATyq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 14:54:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hrF1l1ww9XGXtmBiDlPhob01huW1Fm/Ed7x6Ve1dKIdAUGiew5srxI2xf/U340yH22U/ICu0bb9tebwovnJigYwNwcuOq887emVi86Tn1j7HUjrGUQBIcBr9PDnDm8n18DV/+5nqENJ2nNalgKeOXGJ5JrRPIvATgOZE4sp8r1s=
Message-ID: <cbec11ac0511011154r13e7b695g@mail.gmail.com>
Date: Wed, 2 Nov 2005 08:54:45 +1300
From: Ian McDonald <imcdnzl@gmail.com>
To: Thomas Graf <tgraf@suug.ch>
Subject: Re: [PKT_SCHED]: Rework QoS and/or fair queueing configuration
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, bunk@stusta.de,
       jengelh@linux01.gwdg.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20051101141302.GM23537@postel.suug.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0510280902470.6910@yvahk01.tjqt.qr>
	 <20051031102621.GF8009@stusta.de>
	 <20051031132729.GK23537@postel.suug.ch>
	 <20051101141302.GM23537@postel.suug.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/05, Thomas Graf <tgraf@suug.ch> wrote:
>
> Make "QoS and/or fair queueing" have its own menu, it's too big to be
> inlined into "Network options". Remove the obsolete NET_QOS option.
> Automatically select NET_CLS if needed. Do the same for NET_ESTIMATOR
> but allow it to be selected manually for statistical purposes. Add
> comments to separate queueing from classification. Fix dependencies
> and ordering of classifiers. Improve descriptions/help texts and
> remove outdated pieces.
>
Thomas I think the timing ones can be improved slightly out of the
discussion at here:
http://marc.theaimsgroup.com/?l=linux-netdev&m=112912015311659&w=2

I keep meaning to submit a patch but low on my todo list. Feel free to
do so if you wish or else I will get around to it one day. I know
Arnaldo has also mentioned ktimers for the future (which I haven't yet
read) which may help in this area as well.

Ian
--
Ian McDonald
http://wand.net.nz/~iam4
WAND Network Research Group
University of Waikato
New Zealand
