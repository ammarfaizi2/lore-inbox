Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWARJkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWARJkN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 04:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWARJkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 04:40:12 -0500
Received: from cpc4-cmbg4-4-0-cust18.cmbg.cable.ntl.com ([81.108.205.18]:37385
	"EHLO thekelleys.org.uk") by vger.kernel.org with ESMTP
	id S932147AbWARJkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 04:40:11 -0500
Message-ID: <43CE0CF9.2030003@thekelleys.org.uk>
Date: Wed, 18 Jan 2006 09:40:09 +0000
From: Simon Kelley <simon@thekelleys.org.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Debian/1.7.12-0ubuntu05.04
X-Accept-Language: en
MIME-Version: 1.0
To: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: Re: net 2.6.16-rc1: multiple ipv6 failures
References: <43CDAA58.5000904@pobox.com> <20060117.214750.37718950.davem@davemloft.net>
In-Reply-To: <20060117.214750.37718950.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

> Known problem, fixed by Yoshifuji in current GIT.  /proc/net/if_net6's
> output format got mistakedly changed, and this confused named and
> ifconfig, among other things.

For reference, add dnsmasq to the list of confused userspace: the 
signature error is:

failed to find list of interfaces: No such device

Cheers,

Simon.
