Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbVKUSJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbVKUSJi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 13:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbVKUSJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 13:09:37 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:26032 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S932437AbVKUSJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 13:09:36 -0500
Date: Mon, 21 Nov 2005 10:09:05 -0800
To: Adrian Bunk <bunk@stusta.de>
Cc: jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill drivers/net/irda/sir_core.c
Message-ID: <20051121180905.GB26046@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20051120232904.GM16060@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051120232904.GM16060@stusta.de>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 12:29:04AM +0100, Adrian Bunk wrote:
> EXPORT_SYMBOL's do nowadays belong to the files where the actual 
> functions are.
> 
> Moving the module_init/module_exit to the file with the actual functions 
> has the advantage of saving a few bytes due to the removal of two 
> functions.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

	Go for it.
	Ack-by : Jean Tourrilhes <jt@hpl.hp.com>

	Jean
