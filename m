Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbUJZXB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbUJZXB7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 19:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbUJZXB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 19:01:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26546 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261527AbUJZXBz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 19:01:55 -0400
Message-ID: <417ED750.50403@pobox.com>
Date: Tue, 26 Oct 2004 19:01:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Setting 32bit IO on SATA drives
References: <1098827414l.6518l.0l@werewolf.able.es>
In-Reply-To: <1098827414l.6518l.0l@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> How can I make 32bit IO active ?


32bit isn't relevant if you are using DMA.

libata is hardcoded to use 16bit PIO data transfers.

	Jeff

