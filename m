Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWITGhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWITGhN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 02:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWITGhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 02:37:13 -0400
Received: from mx10.go2.pl ([193.17.41.74]:12197 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1751230AbWITGhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 02:37:12 -0400
Date: Wed, 20 Sep 2006 08:41:14 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, luizluca@gmail.com
Subject: Re: [PATCH] Adds kernel parameter to ignore pci devices
Message-ID: <20060920064114.GA1697@ff.dom.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158710473.32598.116.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-09-2006 02:01, Alan Cox wrote:
> Not sure its the way I'd approach it - in your specific case it should
> be easier to just not compile in EHCI (USB 2.0) support.
 
I'd dare to vote for this idea: it's good for testing
and very practical eg. for comparing performance of similar
devices like network or sound cards. Besides: ehci could
work for other devices.

Best regards,

Jarek P.  
