Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319534AbSIMGF7>; Fri, 13 Sep 2002 02:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319539AbSIMGF7>; Fri, 13 Sep 2002 02:05:59 -0400
Received: from horkos.telenet-ops.be ([195.130.132.45]:60812 "EHLO
	horkos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S319534AbSIMGF7> convert rfc822-to-8bit; Fri, 13 Sep 2002 02:05:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Bart De Schuymer <bart.de.schuymer@pandora.be>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] ebtables - Ethernet bridge tables, for 2.5.34
Date: Fri, 13 Sep 2002 08:12:27 +0200
X-Mailer: KMail [version 1.4]
Cc: buytenh@math.leidenuniv.nl, linux-kernel@vger.kernel.org
References: <200209120836.52062.bart.de.schuymer@pandora.be> <200209130520.41862.bart.de.schuymer@pandora.be> <20020912.212959.114182683.davem@redhat.com>
In-Reply-To: <20020912.212959.114182683.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209130812.27093.bart.de.schuymer@pandora.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It may not be nice that we can't immediately just reuse ipv4/netfilter
> handlers for bridging, but I'm not going to require that you make that
> work before I'll accept your patch.

If you mean using iptables on bridged packets, this is possible with the br-nf 
patch. It is not trivial however, 2 new fields to the sk_buff need to be 
added, a small change in the IP fragment code and a small change in 
ip_tables.c, a change to netfilter.h and netfilter.c. The br-nf patch has 
been under development for over 1.5 years, most work done by Lennert with me 
helping now and then...
So, if you would accept br-nf, that would be great. I think Lennert and me 
would need some time to agree on a few things before submitting anything, 
however...

> Once you work things out with Lennert and he approves the changes,
> I'll apply your patch.

Cool, looking forward to his comments.

-- 
cheers,
Bart

