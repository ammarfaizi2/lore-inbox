Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbVBYF2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVBYF2S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 00:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbVBYF2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 00:28:18 -0500
Received: from fire.osdl.org ([65.172.181.4]:10632 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261583AbVBYF2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 00:28:16 -0500
Date: Thu, 24 Feb 2005 21:24:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] unexport do_settimeofday
Message-Id: <20050224212448.367af4be.akpm@osdl.org>
In-Reply-To: <20050224233742.GR8651@stusta.de>
References: <20050224233742.GR8651@stusta.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> 
>  I haven't found any possible modular usage of do_settimeofday in the 
>  kernel.

Please,

- Add deprecated_if_module

- Use it for do_settimeofday()

- Add do_settimeofday to Documentation/feature-removal-schedule.txt
