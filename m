Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317593AbSGXW0j>; Wed, 24 Jul 2002 18:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317602AbSGXW0j>; Wed, 24 Jul 2002 18:26:39 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:37125 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S317593AbSGXW0j>; Wed, 24 Jul 2002 18:26:39 -0400
Message-Id: <200207242228.g6OMSmbA040560@aslan.scsiguy.com>
To: "KOCHI, Takayoshi" <t-kouchi@mvf.biglobe.ne.jp>
cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] aic7xxx driver doesn't release region 
In-Reply-To: Your message of "Wed, 24 Jul 2002 13:32:54 PDT."
             <20020724132119.2803.T-KOUCHI@mvf.biglobe.ne.jp> 
Date: Wed, 24 Jul 2002 16:28:48 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>This is a patch to fix releasing memory and io regions for the
>aic7xxx driver.  This applies both 2.4- and 2.5-series.

I don't recall when exactly this was fixed in the aic7xxx driver,
but probably 6.2.5 or so.  The 2.5.X kernel must not be using
a recent version of the driver.  Marcelo's tree has 6.2.8
which definitely does not require this patch (won't even apply).

--
Justin
