Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282890AbRL0WYA>; Thu, 27 Dec 2001 17:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282882AbRL0WXu>; Thu, 27 Dec 2001 17:23:50 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:34567 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S282880AbRL0WXb>;
	Thu, 27 Dec 2001 17:23:31 -0500
Date: Thu, 27 Dec 2001 20:23:45 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Steven Walter <srwalter@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] unchecked request_region's in drivers/net
Message-ID: <20011227202345.B30930@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Steven Walter <srwalter@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20011227143812.A19635@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011227143812.A19635@hapablap.dyn.dhs.org>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 27, 2001 at 02:38:12PM -0600, Steven Walter escreveu:
> This patch corrects the request_region calls in drivers/net to have
> their return value checked, and fail appropriately.  Additionally, the
> check_region calls have been removed where prudent.
> 
> I'd like volunteers to test and comment on the patch; if the general consensus is that it's good, I'd like to see it integrated.
> 
> Patch is against kernel 2.4.17, should apply to 2.5 as well.

Good job! But please consider splitting the patch per driver and sending it
to the respective maintainers.

- Arnaldo
