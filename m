Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268474AbUIWOFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268474AbUIWOFb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 10:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268488AbUIWOFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 10:05:31 -0400
Received: from share.sks3.muni.cz ([147.251.211.22]:1234 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S268474AbUIWOF1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 10:05:27 -0400
Date: Thu, 23 Sep 2004 16:02:28 +0200
From: Lukas Hejtmanek <xhejtman@hell.sks3.muni.cz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
       netdev@oss.sgi.com
Subject: Re: 2.6.9-rc2-mm2 fn_hash_insert oops
Message-ID: <20040923140228.GA16675@mail.muni.cz>
References: <20040923103723.GA12145@mail.muni.cz> <E1CARaS-00071j-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1CARaS-00071j-00@gondolin.me.apana.org.au>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 09:16:32PM +1000, Herbert Xu wrote:
> Lukas Hejtmanek <xhejtman@mail.muni.cz> wrote:
> > 
> > However there is still the issue with endless loop in fn_hash_delete :(
> 
> Same problem, same fix.  Can someone think of a generic fix to
> list_for_each_*?

It helped. Thankx.

-- 
Luká¹ Hejtmánek
