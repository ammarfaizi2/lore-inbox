Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWFUQhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWFUQhp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 12:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWFUQhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 12:37:45 -0400
Received: from ns.suse.de ([195.135.220.2]:13716 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932248AbWFUQho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 12:37:44 -0400
From: Andi Kleen <ak@suse.de>
To: Dave Olson <olson@unixfolk.com>
Subject: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check Hyper-transport capabilitiesKJ
Date: Wed, 21 Jun 2006 18:37:30 +0200
User-Agent: KMail/1.9.3
Cc: Allen Martin <AMartin@nvidia.com>, discuss@x86-64.org,
       Brice Goglin <brice@myri.com>, linux-kernel@vger.kernel.org,
       Greg Lindahl <greg.lindahl@qlogic.com>
References: <DBFABB80F7FD3143A911F9E6CFD477B00E48CF12@hqemmail02.nvidia.com> <p73vequomc8.fsf@verdi.suse.de> <Pine.LNX.4.61.0606210920170.30013@osa.unixfolk.com>
In-Reply-To: <Pine.LNX.4.61.0606210920170.30013@osa.unixfolk.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606211837.30056.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 June 2006 18:21, Dave Olson wrote:
> On Wed, 21 Jun 2006, Andi Kleen wrote:
> 
> | "Allen Martin" <AMartin@nvidia.com> writes:
> | 
> | > > 
> | > > NForce4 PCI Express is an unknown - we'll see how that works.
> | > > 
> | > 
> | > MSI is not officially supported on nForce4 and hasn't been fully tested.
> | 
> | Ok thanks for the information. We should definitely disable it by default
> | then, maybe with an boot option so that the speed-over-stability crowd
> | can enable it (+ possibly an oops taint bit) 
> 
> Why disable it, when it's clearly working?  

Because I don't think normal Linux users should be in the hardware validation
business. If the vendor says it's not tested we shouldn't enable it by default.

-Andi
