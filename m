Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbTLXSxD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 13:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbTLXSxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 13:53:02 -0500
Received: from holomorphy.com ([199.26.172.102]:52647 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263787AbTLXSxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 13:53:00 -0500
Date: Wed, 24 Dec 2003 10:52:48 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Giacomo Di Ciocco <admin@nectarine.info>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 "Losing too many ticks!"
Message-ID: <20031224185248.GG27687@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Giacomo Di Ciocco <admin@nectarine.info>,
	linux-kernel@vger.kernel.org
References: <3FE9DFA2.5070203@nectarine.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE9DFA2.5070203@nectarine.info>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 24, 2003 at 07:49:06PM +0100, Giacomo Di Ciocco wrote:
> today i found a problem when upgrading the kernel of this box from
> 2.2.20 to 2.6.0, i tried to enable/disable ACPI support in the bios
> and in the kernel but nothing was resolved.
[...]
> Dec 24 16:36:31 xmas kernel: Losing too many ticks!
> Dec 24 16:36:31 xmas kernel: TSC cannot be used as a timesource. (Are you
> running with SpeedStep?)
> Dec 24 16:36:31 xmas kernel: Falling back to a sane timesource.
> Contact me for more informations. (or tell me to post it here)

This is not particularly harmful. It just means the kernel has detected
some variation in the processor's clock speed and is using a time source
that doesn't change speed along with the processor's clock speed.


-- wli
