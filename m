Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVDSIDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVDSIDg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 04:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVDSIDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 04:03:36 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:39348 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261332AbVDSIDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 04:03:34 -0400
Subject: Re: E1000 - page allocation failure - saga continues :(
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: Lukas Hejtmanek <xhejtman@mail.muni.cz>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4264B202.9080304@univ-nantes.fr>
References: <20050414214828.GB9591@mail.muni.cz>
	 <4263A3B7.6010702@univ-nantes.fr> <20050418122202.GE26030@mail.muni.cz>
	 <4264B202.9080304@univ-nantes.fr>
Content-Type: text/plain; charset=utf-8
Date: Tue, 19 Apr 2005 18:03:30 +1000
Message-Id: <1113897810.5074.66.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-19 at 09:23 +0200, Yann Dupont wrote:
> Lukas Hejtmanek a écrit :

> >Btw, are you using some TCP tweaks? E.g. I have default TCP window size 1MB.
> >
> >  
> >
> Do you have turned NAPI on ??? I tried without it off on e1000 and ...
> surprise !
> Don't have any messages since 12H now (usually I got those in less than 1H)
> 

Possibly kswapd might be unable to get enough CPU to free memory.

-- 
SUSE Labs, Novell Inc.


