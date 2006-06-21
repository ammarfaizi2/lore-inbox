Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbWFUKFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWFUKFg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 06:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWFUKFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 06:05:36 -0400
Received: from ns.suse.de ([195.135.220.2]:31429 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751464AbWFUKFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 06:05:35 -0400
To: "Allen Martin" <AMartin@nvidia.com>
Cc: "Dave Olson" <olson@unixfolk.com>, <discuss@x86-64.org>,
       "Brice Goglin" <brice@myri.com>, <linux-kernel@vger.kernel.org>,
       "Greg Lindahl" <greg.lindahl@qlogic.com>
Subject: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check Hyper-transport capabilitiesKJ
References: <DBFABB80F7FD3143A911F9E6CFD477B00E48CF12@hqemmail02.nvidia.com>
From: Andi Kleen <ak@suse.de>
Date: 21 Jun 2006 12:05:27 +0200
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B00E48CF12@hqemmail02.nvidia.com>
Message-ID: <p73vequomc8.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Allen Martin" <AMartin@nvidia.com> writes:

> > 
> > NForce4 PCI Express is an unknown - we'll see how that works.
> > 
> 
> MSI is not officially supported on nForce4 and hasn't been fully tested.

Ok thanks for the information. We should definitely disable it by default
then, maybe with an boot option so that the speed-over-stability crowd
can enable it (+ possibly an oops taint bit) 

-Andi
