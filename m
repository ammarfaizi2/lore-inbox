Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbTFIKrM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 06:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262811AbTFIKrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 06:47:12 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:35337 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262763AbTFIKrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 06:47:11 -0400
Date: Mon, 9 Jun 2003 15:00:18 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "David S. Miller" <davem@redhat.com>
Cc: willy@debian.org, linux-kernel@vger.kernel.org, davidm@hpl.hp.com
Subject: Re: [PATCH] [3/3] PCI segment support
Message-ID: <20030609150018.B15283@jurassic.park.msu.ru>
References: <20030609140749.A15138@jurassic.park.msu.ru> <1055154054.9884.2.camel@rth.ninka.net> <20030609144242.A15283@jurassic.park.msu.ru> <20030609.034304.52179334.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030609.034304.52179334.davem@redhat.com>; from davem@redhat.com on Mon, Jun 09, 2003 at 03:43:04AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 09, 2003 at 03:43:04AM -0700, David S. Miller wrote:
>    Root buses often do not have the self device, e.g. on alpha.
> 
> How can people make PCI config space accesses to them?

The root level controllers itself are not accessible from
PCI config space (unlike x86 host bridges). They have
dedicated control registers somewhere in the IO space.

Ivan.
