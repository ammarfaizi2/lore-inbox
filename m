Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbUCLPlX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 10:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbUCLPlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 10:41:23 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:3332 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262195AbUCLPlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 10:41:21 -0500
Date: Fri, 12 Mar 2004 18:41:15 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4 on Alpha uninterruptible sleep of processes
Message-ID: <20040312184115.B680@jurassic.park.msu.ru>
References: <20040312154613.7567adab@hdg.gigerstyle.ch> <20040312182754.A680@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040312182754.A680@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Fri, Mar 12, 2004 at 06:27:54PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 06:27:54PM +0300, Ivan Kokshaysky wrote:
> -	"	cmovgt	%0,%0,%1\n"
> +	"	cmovgt	%0,0,%1\n"

Oops. This is wrong, please ignore.
Will investigate further.

Ivan.
