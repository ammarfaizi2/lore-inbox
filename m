Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbUBWVak (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 16:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbUBWVWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 16:22:13 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:5649 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262042AbUBWVSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 16:18:50 -0500
Date: Mon, 23 Feb 2004 21:18:44 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Michael Hunold <hunold@linuxtv.org>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] tda1004x DVB frontend update
Message-ID: <20040223211844.A14186@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michael Hunold <hunold@linuxtv.org>, torvalds@osdl.org,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <10775702831806@convergence.de> <10775702843054@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <10775702843054@convergence.de>; from hunold@linuxtv.org on Mon, Feb 23, 2004 at 04:05:01PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  #ifndef DVB_TDA1004X_FIRMWARE_FILE
> -#define DVB_TDA1004X_FIRMWARE_FILE "/usr/lib/hotplug/firmware/tda1004x.mc"
> +#define DVB_TDA1004X_FIRMWARE_FILE "/usr/lib/hotplug/firmware/tda1004x.bin"
>  #endif

Why would the kernel driver want to know the exact path of the firmware file?

