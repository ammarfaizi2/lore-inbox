Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422900AbWBOGVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422900AbWBOGVD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 01:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422998AbWBOGVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 01:21:03 -0500
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:4240 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1422900AbWBOGVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 01:21:00 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] make INPUT a bool
Date: Wed, 15 Feb 2006 01:20:58 -0500
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
References: <20060214152218.GI10701@stusta.de>
In-Reply-To: <20060214152218.GI10701@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602150120.58844.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 February 2006 10:22, Adrian Bunk wrote:
> Make INPUT a bool.
> 
> INPUT!=y is only possible if EMBEDDED=y, and in such cases it doesn't 
> make that much sense to make it modular.
>

Adrian,

We also need to get rid of input_register_device pinning input module
and input_dev release function decrementing module's refcount.

Thanks!

-- 
Dmitry
