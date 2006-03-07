Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWCGV1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWCGV1K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 16:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWCGV1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 16:27:10 -0500
Received: from quechua.inka.de ([193.197.184.2]:16013 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S932313AbWCGV1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 16:27:09 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Dead code in drivers/isdn/avm/avmcard.h
References: <1141760900.7561.2.camel@alice>
Organization: private Linux site, southern Germany
From: Olaf Titz <olaf@bigred.inka.de>
Date: Tue, 07 Mar 2006 22:17:49 +0100
Message-ID: <E1FGjYz-0004X6-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  					i = 0;
> -					if (i == 0)
> -						break;
> +					break;
>  					/* fall through */
>  				default:

This leaves the "fall through" comment as bogus, remove that too.

Olaf

