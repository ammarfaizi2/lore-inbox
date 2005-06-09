Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262349AbVFIN4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbVFIN4W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 09:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbVFIN4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 09:56:21 -0400
Received: from one.firstfloor.org ([213.235.205.2]:33694 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262349AbVFIN4R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 09:56:17 -0400
To: James Ketrenos <jketreno@linux.intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Netdev list <netdev@oss.sgi.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       "James P. Ketrenos" <ipw2100-admin@linux.intel.com>
Subject: Re: ipw2100: firmware problem
References: <20050608142310.GA2339@elf.ucw.cz>
	<42A723D3.3060001@linux.intel.com>
From: Andi Kleen <ak@muc.de>
Date: Thu, 09 Jun 2005 15:56:15 +0200
In-Reply-To: <42A723D3.3060001@linux.intel.com> (James Ketrenos's message of
 "Wed, 08 Jun 2005 11:58:59 -0500")
Message-ID: <m1is0nvdkw.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Ketrenos <jketreno@linux.intel.com> writes:
>>
> We've been looking into whether the initrd can have the firmware affixed
> to the end w/ some magic bytes to identify it.  If it works, enhancing
> the request_firmware to support both hotplug and an initrd approach may
> be reasonable.

That space is already used in common distributions for replacement DSDTs

I guess at some point we will need a file system in there, but - oops -
we already have one, dont we? :)

-Andi
