Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267380AbUIWVoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267380AbUIWVoL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267423AbUIWVkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:40:49 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:33213 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S267380AbUIWViG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:38:06 -0400
Subject: Re: 2.6.9-rc2-mm2 fn_hash_insert oops
From: Nuno Ferreira <nuno.ferreira@graycell.biz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: akpm@osdl.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
In-Reply-To: <E1CARaS-00071j-00@gondolin.me.apana.org.au>
References: <E1CARaS-00071j-00@gondolin.me.apana.org.au>
Content-Type: text/plain
Organization: Graycell
Date: Thu, 23 Sep 2004 22:38:04 +0100
Message-Id: <1095975485.4339.1.camel@taz.graycell.biz>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Qui, 2004-09-23 at 21:16 +1000, Herbert Xu wrote:
> Lukas Hejtmanek <xhejtman@mail.muni.cz> wrote:
> > 
> > However there is still the issue with endless loop in fn_hash_delete :(
> 
> Same problem, same fix.  Can someone think of a generic fix to
> list_for_each_*?
> 

This also fixed the problem I reported earlier with the machine freezing
when my Speedtouch USB ADSL modem connected.

Thanks

