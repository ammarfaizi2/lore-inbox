Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752034AbWG1QlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbWG1QlL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 12:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752044AbWG1QlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 12:41:11 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:33167 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1752034AbWG1QlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 12:41:10 -0400
Date: Fri, 28 Jul 2006 18:40:21 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>,
       "Larson, Greg" <GLarson@analogic.com>
Subject: Re: Driver timeout
In-Reply-To: <Pine.LNX.4.61.0607281152030.5161@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0607281840020.4972@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0607281152030.5161@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Hello list,
>What is the correct error code for a driver to return if
>the requested operation timed out?

-ETIMEDOUT IIRC. Errno number 110 for sure.


Jan Engelhardt
-- 
