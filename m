Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262934AbVAFRiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262934AbVAFRiu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 12:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262933AbVAFRfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 12:35:43 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:43963 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262930AbVAFRe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 12:34:59 -0500
Subject: Re: Questions about the CMD640 and RZ1000 bugfix support options
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrey Melnikoff <temnota+news@kmv.ru>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <e0qta2-7jr.ln1@kenga.kmv.ru>
References: <41D5D206.1040107@mathematica.scientia.net>
	 <1104676209.15004.58.camel@localhost.localdomain>
	 <e0qta2-7jr.ln1@kenga.kmv.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105025417.17176.222.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 06 Jan 2005 16:30:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-01-05 at 18:58, Andrey Melnikoff wrote:
> > > At least the second of those two seems to cause some little slowdown 
> > > ("This may slow disk throughput by a few percent, but at least things 
> > They only trigger for the affected chipsets
> But enabled by default. Maybe disable it by default ? Or make depend with 
> CONFIG_M586 || CONFIG_M586TSC || CONFIG_M586MMX ?

They should be enabled by default. That makes it safer for default
compiles, and their code size is close to if not nil because it can all
be __devinit or __init

