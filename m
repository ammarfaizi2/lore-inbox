Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbUFCJ1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbUFCJ1M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 05:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbUFCJ1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 05:27:12 -0400
Received: from cpc5-hitc2-5-0-cust152.lutn.cable.ntl.com ([82.0.115.152]:13258
	"EHLO zog.reactivated.net") by vger.kernel.org with ESMTP
	id S261976AbUFCJ1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 05:27:10 -0400
Message-ID: <40BEF10F.1040108@gentoo.org>
Date: Thu, 03 Jun 2004 10:36:15 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040506)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.7-rc1-mm1: libata flooding my log
References: <40B8E8D4.1010905@gmx.de> <40B8EB07.6000700@pobox.com> <40B8F601.2000600@gmx.de> <40BD8B7A.2010901@gmx.de> <40BEB840.8060305@gmx.de>
In-Reply-To: <40BEB840.8060305@gmx.de>
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash K. Cheemplavam wrote:
> I found another interesting thing: It seems those errors only appear 
> when I use mozilla thunderbird! Any idea what tb is trying to do to the 
> hd? As I said earlier kernels didn't report such errors. (Are those 
> actually errors?)

I'm having similar problems (posted to linux-ide last week). Its not just 
thunderbird though, I can easily reproduce this under heavy disk activity 
(e.g. rsync'ing lots of data with a local server while unpacking/patching a 
kernel).

Daniel
