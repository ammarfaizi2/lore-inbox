Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbUFBLJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbUFBLJf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 07:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUFBLJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 07:09:35 -0400
Received: from mta01-svc.ntlworld.com ([62.253.162.41]:47386 "EHLO
	mta01-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S261802AbUFBLJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 07:09:34 -0400
Date: Wed, 2 Jun 2004 12:09:32 +0100
From: Mike Jagdis <mjagdis@eris-associates.co.uk>
To: Russell Leighton <russ@elegant-software.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: F_SETSIG broken/changed in 2.6 for UDP and TCP sockets?
Message-ID: <20040602110932.GA22369@eris-associates.co.uk>
References: <40BB7D34.8060200@elegant-software.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BB7D34.8060200@elegant-software.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2004 at 02:45:08PM -0400, Russell Leighton wrote:
> In the udp case, I when I listen for multicast packets my app only 
> receives them when I am running a tcpdump (bizarre!).

That bit at least isn't so surprising - tcpdump is probably
setting the interface to promiscuous mode which lets you
receive everything. What does groups does "netstat -gn"
say you are subscribed to, though?

Mike

-- 
Mike Jagdis                        Web: http://www.eris-associates.co.uk
Eris Associates Limited            Tel: +44 7780 608 368
Reading, England                   Fax: +44 118 926 6974
