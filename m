Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262660AbUKTLt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262660AbUKTLt7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 06:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbUKTLt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 06:49:59 -0500
Received: from holomorphy.com ([207.189.100.168]:37253 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262660AbUKTLtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 06:49:10 -0500
Date: Sat, 20 Nov 2004 03:45:47 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.6.10-rc2-mm2: OSS ac97_codec.h: #include pci.h
Message-ID: <20041120114547.GU2714@holomorphy.com>
References: <20041118021538.5764d58c.akpm@osdl.org> <20041118124220.GB2268@holomorphy.com> <20041120113545.GC2754@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041120113545.GC2754@stusta.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 04:42:20AM -0800, William Lee Irwin III wrote:
>> +struct pci_dev;
>>  extern int ac97_tune_hardware(struct pci_dev *pdev, struct ac97_quirk *quirk, int override);
>>  
>>  #endif /* _AC97_CODEC_H_ */

On Sat, Nov 20, 2004 at 12:35:45PM +0100, Adrian Bunk wrote:
> Wouldn't it be better to simply #include pci.h?
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Could be; I opted for avoiding header tangling by default, but if most
includers will use pci.h anyway, so be it.


-- wli
