Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWALDzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWALDzc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 22:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWALDzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 22:55:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39631 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751150AbWALDzb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 22:55:31 -0500
Date: Wed, 11 Jan 2006 19:54:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: mchehab@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, mchehab@brturbo.com.br,
       mchehab@infradead.org
Subject: Re: [PATCH 13/20] V4L/DVB (3345) Fixes some bad global variables
Message-Id: <20060111195445.17d7cae4.akpm@osdl.org>
In-Reply-To: <20060112025557.PS14543900013@infradead.org>
References: <20060112025516.PS38541900000@infradead.org>
	<20060112025557.PS14543900013@infradead.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mchehab@infradead.org wrote:
>
> +int msp_debug    = 0;    /* msp_debug output */
>  +int msp_once     = 0;    /* no continous stereo monitoring */
>  +int msp_amsound  = 0;    /* hard-wire AM sound at 6.5 Hz (france),
>   			       the autoscan seems work well only with FM... */
>  -int standard = 1;    /* Override auto detect of audio standard, if needed. */
>  -int dolby    = 0;
>  +int msp_standard = 1;    /* Override auto detect of audio msp_standard, if needed. */
>  +int msp_dolby    = 0;

argh, I removed all the "= 0"s and they've come back.
