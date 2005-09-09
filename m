Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbVIIQ3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbVIIQ3Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 12:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbVIIQ3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 12:29:16 -0400
Received: from cantor2.suse.de ([195.135.220.15]:45742 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751422AbVIIQ3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 12:29:16 -0400
From: Andi Kleen <ak@suse.de>
To: "Brown, Len" <len.brown@intel.com>
Subject: Re: [PATCH] [2.6.13-mm2] set IBM ThinkPad extras to default n in Kconfig
Date: Fri, 9 Sep 2005 18:29:14 +0200
User-Agent: KMail/1.8
Cc: akpm@osdl.org, "Borislav Petkov" <petkov@uni-muenster.de>,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <F7DC2337C7631D4386A2DF6E8FB22B30048FA292@hdsmsx401.amr.corp.intel.com>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30048FA292@hdsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509091829.15073.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 September 2005 18:06, Brown, Len wrote:

> I'm not sure what to do here -- what use-model
> should we tune default Kconfig for?

I would just give no default for the platform drivers. They are not 
exactly mission critical. The default stuff is for more for
optons that prevent booting when commonly set wrong etc.

-Andi
