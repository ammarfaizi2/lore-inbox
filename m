Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274471AbRIYEKd>; Tue, 25 Sep 2001 00:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274477AbRIYEKX>; Tue, 25 Sep 2001 00:10:23 -0400
Received: from [209.202.108.240] ([209.202.108.240]:62994 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S274471AbRIYEKT>; Tue, 25 Sep 2001 00:10:19 -0400
Date: Tue, 25 Sep 2001 00:10:29 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Small change to pnp_bios.c
In-Reply-To: <3BB0021E.D1977DBD@yahoo.co.uk>
Message-ID: <Pine.LNX.4.33.0109250009170.23392-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2001, Thomas Hood wrote:

> -       for(i=0;i<0xff;i++) {
> +       for(i=0,num=0;i<0xff,num!=0xff;i++) {

That middle comma should be || or &&, right?

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>


