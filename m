Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbTFXUVn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 16:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbTFXUVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 16:21:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3005 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263245AbTFXUUH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 16:20:07 -0400
Message-ID: <3EF8B5BB.6070400@pobox.com>
Date: Tue, 24 Jun 2003 16:34:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: bunk@fs.tum.de, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Re: [2.5 patch] ULL postfixes for tg3.c
References: <20030624174811.GW3710@fs.tum.de> <20030624.131228.78737223.davem@redhat.com>
In-Reply-To: <20030624.131228.78737223.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> I'll apply this, the INT64_MAX or whatever ideas are just
> stupid.  We're saying what "bits" the device supports when
> it does DMA, so we should pass in a "bit" mask.


no need.  look what's in the pipe already.

