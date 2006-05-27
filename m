Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbWE0WIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbWE0WIV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 18:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbWE0WIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 18:08:21 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:54486 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S964994AbWE0WIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 18:08:20 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: Re: [PATCH 23/32] readahead: seeking reads method
Date: Sun, 28 May 2006 00:04:31 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060527154849.927021763@localhost.localdomain> <348745096.16246@ustc.edu.cn>
In-Reply-To: <348745096.16246@ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605280004.32941.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

On Saturday, 27. May 2006 17:49, Wu Fengguang wrote:
> Readahead policy on read after seeking.
> 
> It tries to detect sequences like:
> 	seek(), 5*read(); seek(), 6*read(); seek(), 4*read(); ...

This is basically "fast forward" and "fast backward" of media players.
Did you try some tests with that? Hard disk recording people will love you.

Just watch a nice movies while testing this and you can enjoy both: 
Your work succeeding and jumping around in a good movie :-)


Regards

Ingo Oeser
