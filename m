Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755510AbWK0AWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755510AbWK0AWY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 19:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755518AbWK0AWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 19:22:24 -0500
Received: from colin.muc.de ([193.149.48.1]:32015 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1755510AbWK0AWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 19:22:23 -0500
Date: 27 Nov 2006 01:22:21 +0100
Date: Mon, 27 Nov 2006 01:22:21 +0100
From: Andi Kleen <ak@muc.de>
To: Yinghai Lu <yinghai.lu@amd.com>
Cc: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] x86: remove duplicated parser for "pci=noacpi"
Message-ID: <20061127002221.GA57506@muc.de>
References: <86802c440611261523q4bbd4fbbob5dd36db12dd9a01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86802c440611261523q4bbd4fbbob5dd36db12dd9a01@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2006 at 03:23:36PM -0800, Yinghai Lu wrote:
> 

Are you sure it's correct? The drivers/pci pci= parsing
isn't early and there tend to be nasty ordering issues.
I can't see where it would go wrong here, but it probably
needs very careful double checking.

-Andi
