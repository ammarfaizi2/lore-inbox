Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbUCRJQl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 04:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262455AbUCRJQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 04:16:41 -0500
Received: from denise.shiny.it ([194.20.232.1]:57580 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S262109AbUCRJQk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 04:16:40 -0500
Date: Thu, 18 Mar 2004 10:16:28 +0100 (CET)
From: Giuliano Pochini <pochini@denise.shiny.it>
To: =?iso-8859-2?q?Micha=B3_Roszka?= <michal@roszka.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: [.config] CONFIG_THERM_WINDTUNNEL
In-Reply-To: <200403180821.44199.michal@roszka.pl>
Message-ID: <Pine.LNX.4.58.0403181012300.29633@denise.shiny.it>
References: <200403180821.44199.michal@roszka.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Mar 2004, [iso-8859-2] Micha³ Roszka wrote:

> There is an option in kernel configuration (2.6.3):
> CONFIG_THERM_WINDTUNNEL=m
> How does G4 Windtunnel thermal support work? Does it make an ability to change
> fans speed by the OS or maybe something other/else?

Yes, it works. It controls the speed of the CPU fan according to the
temperature. Do not forget to load the i2c_keywest module.


--
Giuliano.
