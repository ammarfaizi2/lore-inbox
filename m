Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbVHHW43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbVHHW43 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbVHHW43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:56:29 -0400
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:33411
	"HELO linuxace.com") by vger.kernel.org with SMTP id S932337AbVHHW42
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:56:28 -0400
Date: Mon, 8 Aug 2005 15:56:27 -0700
From: Phil Oester <kernel@linuxace.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12->2.6.13-rc6 SMT changes -- intentional?
Message-ID: <20050808225627.GA7267@linuxace.com>
References: <20050808222146.GA7123@linuxace.com> <42F7DDE2.8020403@vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F7DDE2.8020403@vc.cvut.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 12:34:10AM +0200, Petr Vandrovec wrote:
> It looks like that ACPI is gone...  Can you recheck your .config that
> you still have ACPI enabled?
> 							Petr

Hmmff...yup, you are correct.  Which is interesting, since I just copied
the 2.6.12.4 .config, and did a make oldconfig on it.  Looks like ACPI
is now dependent on CONFIG_PM, while it was not before.  Wonder how
many others this will bite...

Thanks,
Phil
