Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266118AbUA1Xoq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 18:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266210AbUA1Xoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 18:44:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42115 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266118AbUA1Xoo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 18:44:44 -0500
Message-ID: <40184960.7030207@pobox.com>
Date: Wed, 28 Jan 2004 18:44:32 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Hollis Blanchard <hollisb@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       francis.wiran@hp.com
Subject: Re: [PATCH] cpqarray update
References: <200401262002.i0QK2iAH031857@hera.kernel.org> <40157552.3040405@pobox.com> <15D09760-51A9-11D8-AF96-000A95A0560C@us.ibm.com> <40184845.3030008@pobox.com>
In-Reply-To: <40184845.3030008@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Actually I disagree with GregKH on this.
> 
> The register/unregister functions need to be returning error codes, 
> _not_ the count of interfaces registered.  It is trivial to count the 
> registered interfaces in the driver itself, but IMO far more important 
> to propagate fatal errors back to the original caller.

Nevermind, this got fixed.  I'm still worried about the '1' return 
value, though, for zero controllers found.

	Jeff


