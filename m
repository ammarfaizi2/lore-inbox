Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWEQMHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWEQMHW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 08:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWEQMHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 08:07:22 -0400
Received: from mail.electro-mechanical.com ([216.184.71.30]:28096 "EHLO
	mail.electro-mechanical.com") by vger.kernel.org with ESMTP
	id S932214AbWEQMHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 08:07:21 -0400
Date: Wed, 17 May 2006 08:07:18 -0400
From: William Thompson <wt@electro-mechanical.com>
To: linux-kernel@vger.kernel.org
Subject: Targus USB2 port replicator on 2.6.12+
Message-ID: <20060517120718.GN18746@electro-mechanical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tested a Targus PA095 with 2.6.12, 2.6.14 and 2.6.17-rc4 with the same
results.

Problem: The ethernet (driven by pegasus) does not work and spews error
messages.

The message:
May 17 08:01:43 potato kernel: [1384852.200880] pegasus 1-1.3.5:1.0: ctrl_callback, status -71
<repeats over 700 times in 1 second>

This did work with 2.6.10.  I do not know about 2.6.11.

Tested on 2 entirely different machines with the same result.

I also attempted to use the 2.6.10 pegasus.[ch] in 2.6.14 with the same
result.
