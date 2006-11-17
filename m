Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424722AbWKQBNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424722AbWKQBNJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 20:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424853AbWKQBNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 20:13:09 -0500
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:14990 "EHLO
	mail.lidskialf.net") by vger.kernel.org with ESMTP id S1424722AbWKQBNH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 20:13:07 -0500
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: v4l-dvb-maintainer@linuxtv.org
Subject: Re: [v4l-dvb-maintainer] dvb_frontend_swzigzag(): uninitialized variable usage
Date: Fri, 17 Nov 2006 01:13:02 +0000
User-Agent: KMail/1.9.4
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
References: <20061106182714.GA8099@stusta.de>
In-Reply-To: <20061106182714.GA8099@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611170113.02689.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 November 2006 18:27, Adrian Bunk wrote:
> The Coverity checker spotted the following in
> drivers/media/dvb/dvb-core/dvb_frontend.c:
>
> <--  snip  -->
>
> ...
> static void dvb_frontend_swzigzag(struct dvb_frontend *fe)
> {
>         fe_status_t s;

[snip]

thanks, fix should be in HG soon.

