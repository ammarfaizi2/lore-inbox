Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262224AbULMLJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbULMLJk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 06:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbULMLJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 06:09:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40424 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262216AbULMLJf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 06:09:35 -0500
Message-ID: <41BD7866.4010009@pobox.com>
Date: Mon, 13 Dec 2004 06:09:26 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Alan J. Wylie" <alan@wylie.me.uk>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       EC <wingman@waika9.com>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: 2.4.29-pre1 OOPS early in boot with Intel ICH5 SATA controller
References: <16824.8109.697757.673632@devnull.wylie.me.uk>	<41BB41DC.6020808@pobox.com> <16829.29661.747368.799519@devnull.wylie.me.uk>
In-Reply-To: <16829.29661.747368.799519@devnull.wylie.me.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible for you to enable the following two #ifdefs in 
include/linux/libata.h, and send me the output?

/*
  * compile-time options
  */
#undef ATA_DEBUG                /* debugging output */
#undef ATA_VERBOSE_DEBUG        /* yet more debugging output */


