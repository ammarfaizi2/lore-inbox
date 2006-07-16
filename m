Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946073AbWGPOKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946073AbWGPOKc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 10:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946075AbWGPOKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 10:10:32 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:266 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1946073AbWGPOKb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 10:10:31 -0400
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Jim Gifford <maillist@jg555.com>, bunk@stusta.de, davem@davemloft.net,
       dwmw2@infradead.org, arjan@infradead.org, linux-kernel@vger.kernel.org,
       ralf@linux-mips.org
Subject: Re: 2.6.18 Headers - Long
References: <44B7F062.8040102@jg555.com>
	<1152905987.3159.46.camel@laptopd505.fenrus.org>
	<1152908202.3191.98.camel@pmac.infradead.org>
	<20060714.131957.57444250.davem@davemloft.net>
	<44B80543.4050608@jg555.com>
	<20060714213323.e610b348.rdunlap@xenotime.net>
From: Nix <nix@esperi.org.uk>
X-Emacs: Lovecraft was an optimist.
Date: Sun, 16 Jul 2006 15:08:48 +0100
In-Reply-To: <20060714213323.e610b348.rdunlap@xenotime.net> (Randy Dunlap's message of "15 Jul 2006 05:32:20 +0100")
Message-ID: <87zmf9d4lr.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jul 2006, Randy Dunlap prattled cheerily:
> On Fri, 14 Jul 2006 13:57:39 -0700 Jim Gifford wrote:
> 
>> Who's maintaining util-linux these days, we probably should get a patch 
>> to them.
> 
>   Adrian Bunk <bunk@stusta.de>

... and I sent him a patch months ago, and it was applied: the cramfs
tools in util-linux no longer use PAGE_SIZE, and hasn't since
2.13-pre5. (mkswap still references it, but that usage is *optional* and
doesn't happen if PAGE_SIZE isn't defined.)
