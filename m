Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbVHBUVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVHBUVd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 16:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVHBUVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 16:21:33 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:52651 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261762AbVHBUU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 16:20:58 -0400
Subject: Re: Touchpad errors
From: Lee Revell <rlrevell@joe-job.com>
To: Dmitrij Bogush <dmitrij.bogush@gmail.com>
Cc: dtor_core@ameritech.net, sboyce@blueyonder.co.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <2ac89c700508021314f42da6a@mail.gmail.com>
References: <42EF633B.6080209@blueyonder.co.uk>
	 <d120d500050802072256a4d7ee@mail.gmail.com>
	 <2ac89c700508021314f42da6a@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 02 Aug 2005 16:20:55 -0400
Message-Id: <1123014056.12562.24.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-03 at 00:14 +0400, Dmitrij Bogush wrote:
> This happens when some software check battery state or current cpu
> rate too often.

Acer laptops are notorious for buggy SMM implementations that disable
interrupts for many timer ticks.  Does it work any better with HZ=100?

Lee

