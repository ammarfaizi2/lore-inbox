Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268337AbTCCERT>; Sun, 2 Mar 2003 23:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268341AbTCCERS>; Sun, 2 Mar 2003 23:17:18 -0500
Received: from holomorphy.com ([66.224.33.161]:36497 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268337AbTCCERS>;
	Sun, 2 Mar 2003 23:17:18 -0500
Date: Sun, 2 Mar 2003 20:27:25 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5][CHECKER] rtc locking
Message-ID: <20030303042725.GN1195@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.50.0303022317390.25240-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0303022317390.25240-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 02, 2003 at 11:19:57PM -0500, Zwane Mwaikambo wrote:
> Index: linux-2.5.62-numaq/drivers/char/rtc.c
[... good patch]

Do you think some kind of API safety (e.g. removing *_lock_irq() in
favor of *_lock_irqsave()) would be worthwhile for catching these kinds
of errors?



-- wli
