Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267950AbTCFJiW>; Thu, 6 Mar 2003 04:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267951AbTCFJiW>; Thu, 6 Mar 2003 04:38:22 -0500
Received: from buitenpost.surfnet.nl ([192.87.108.12]:10900 "EHLO
	buitenpost.surfnet.nl") by vger.kernel.org with ESMTP
	id <S267950AbTCFJiW>; Thu, 6 Mar 2003 04:38:22 -0500
Date: Thu, 6 Mar 2003 10:48:52 +0100
To: James Morris <jmorris@intercode.com.au>
Cc: Brian Litzinger <brian@top.worldcontrol.com>,
       "David S. Miller" <davem@redhat.com>, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Booting 2.5.63 vs 2.4.20 I can't read multicast data
Message-ID: <20030306094852.GC1104@pangsit>
References: <20030304223953.GA3114@pangsit> <Pine.LNX.4.44.0303061605001.27962-100000@blackbird.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303061605001.27962-100000@blackbird.intercode.com.au>
X-Mailer: Mutt on Debian GNU/Linux sid
X-Editor: vim
X-Organisation: SURFnet bv
X-Address: Radboudburcht, P.O. Box 19035, 3501 DA Utrecht, NL
X-Phone: +31 302 305 305
X-Telefax: +31 302 305 329
User-Agent: Mutt/1.5.3i
From: Niels den Otter <otter@surfnet.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James,

On Thursday,  6 March 2003, James Morris wrote:
> On Tue, 4 Mar 2003, Niels den Otter wrote:
> > You appear to be strugling with the same problem I have. What I find
> > is that the multicast application binds to the loopback instead of
> > ethernet interface (also no IGMP joins are send out on the ethernet
> > interface).
> 
> Please try the patch below.

This fixes the IGMP problem. Thanks for the patch!


-- Niels
