Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbVFVXuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVFVXuS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 19:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVFVXqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 19:46:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:19892 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262596AbVFVXhQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 19:37:16 -0400
Date: Thu, 23 Jun 2005 01:37:09 +0200
From: Andi Kleen <ak@suse.de>
To: YhLu <YhLu@tyan.com>
Cc: Peter Buckingham <peter@pantasys.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 with dual way dual core ck804 MB
Message-ID: <20050622233709.GE14251@wotan.suse.de>
References: <3174569B9743D511922F00A0C94314230AF96F9B@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C94314230AF96F9B@TYANWEB>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 04:37:37PM -0700, YhLu wrote:
> andi,
> 
> do you mean the apic id lifting for opteron?

Yes, with local APIC numbers > 8 physical mode needs
to be used because logical mode only supports 8.

-Andi

