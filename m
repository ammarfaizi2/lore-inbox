Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264812AbUEMU4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264812AbUEMU4z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 16:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264832AbUEMU4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 16:56:55 -0400
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:63749 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S264812AbUEMU4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 16:56:53 -0400
Date: Thu, 13 May 2004 22:57:40 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ICH6/6300ESB i2c support
Message-Id: <20040513225740.28501501.khali@linux-fr.org>
In-Reply-To: <26CEE2C804D7BE47BC4686CDE863D0F5B1C46A@orsmsx410.jf.intel.com>
References: <26CEE2C804D7BE47BC4686CDE863D0F5B1C46A@orsmsx410.jf.intel.com>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The reason I have the renumbering in pci_ids.h and the new device
> support in i2c-i801 in the same patch, is that the new device support
> is dependent on the devices being added to pci_ids.h.  However, if it
> is the consensus that these be two separate patches, I can separate
> them.

I think it's better to split because the first patch (renumbering) seems
to be a good thing even if the second patch were not to be applied.
Experience proves that individual patches that do just one thing are
more likely to be accepted quickly than big ones, thus my advice.

> As far as using the ICHx model name is concerned; I can not use the
> model name "82801xx" until after the product has launched.  I have
> also seen requests to use the ICHx name rather then the model number. 
> Again, if it is the consensus, I can go back after the product
> launches and change all of the #defines, for the device, to use the
> model number rather than the "common" name.

That won't be needed. If you have good reasons for your choice, it's
fine with me. I was just wanting to avoid a policy change without a
reason. Since you know why you changed, it's OK (with me at least).

> I will look into providing the same patch for the 2.4 kernel.

Thanks :)

-- 
Jean Delvare
http://khali.linux-fr.org/
