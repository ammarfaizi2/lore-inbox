Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319777AbSIMULS>; Fri, 13 Sep 2002 16:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319779AbSIMULS>; Fri, 13 Sep 2002 16:11:18 -0400
Received: from 213-152-55-49.dsl.eclipse.net.uk ([213.152.55.49]:16102 "EHLO
	monkey.daikokuya.co.uk") by vger.kernel.org with ESMTP
	id <S319777AbSIMULQ>; Fri, 13 Sep 2002 16:11:16 -0400
Date: Fri, 13 Sep 2002 21:12:58 +0100
From: Neil Booth <neil@daikokuya.co.uk>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Bob_Tracy <rct@gherkin.frus.com>, dag@brattli.net,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.34: IR __FUNCTION__ breakage
Message-ID: <20020913201258.GA11481@daikokuya.co.uk>
References: <Pine.LNX.4.44.0209121414570.10048-100000@hawkeye.luckynet.adm> <3D820BC9.5080207@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D820BC9.5080207@domdv.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Steinmetz wrote:-

> At least for gcc 3.2 this would be better:
> 
> #define DERROR(dbg, fmt, args...) \
>     do { if (DEBUG_##dbg) \
>         printk(KERN_INFO "irnet: %s(): " fmt, __FUNCTION__, ##args); \
>     } while(0)
> 
> Unfortunately this doesn't work with gcc 2.95.3.

I think it might if you put a space after __FUNCTION__ and before the
comma.

Neil.
