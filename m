Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWFUQWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWFUQWL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 12:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWFUQWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 12:22:11 -0400
Received: from osa.unixfolk.com ([209.204.179.118]:18602 "EHLO
	osa.unixfolk.com") by vger.kernel.org with ESMTP id S932076AbWFUQWJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 12:22:09 -0400
Date: Wed, 21 Jun 2006 09:21:40 -0700 (PDT)
From: Dave Olson <olson@unixfolk.com>
To: Andi Kleen <ak@suse.de>
Cc: Allen Martin <AMartin@nvidia.com>, discuss@x86-64.org,
       Brice Goglin <brice@myri.com>, linux-kernel@vger.kernel.org,
       Greg Lindahl <greg.lindahl@qlogic.com>
Subject: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check
 Hyper-transport capabilitiesKJ
In-Reply-To: <p73vequomc8.fsf@verdi.suse.de>
Message-ID: <Pine.LNX.4.61.0606210920170.30013@osa.unixfolk.com>
References: <DBFABB80F7FD3143A911F9E6CFD477B00E48CF12@hqemmail02.nvidia.com>
 <p73vequomc8.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006, Andi Kleen wrote:

| "Allen Martin" <AMartin@nvidia.com> writes:
| 
| > > 
| > > NForce4 PCI Express is an unknown - we'll see how that works.
| > > 
| > 
| > MSI is not officially supported on nForce4 and hasn't been fully tested.
| 
| Ok thanks for the information. We should definitely disable it by default
| then, maybe with an boot option so that the speed-over-stability crowd
| can enable it (+ possibly an oops taint bit) 

Why disable it, when it's clearly working?   Disable it for the
onboard ethernet, perhaps, but as far as I know, nobody has reported
any MSI issues on nforce4?   I've been in the vendor position often
enough to know that "not supported" doesn't mean "known to not work".

Dave Olson
olson@unixfolk.com
http://www.unixfolk.com/dave
