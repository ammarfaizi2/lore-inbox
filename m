Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbTJNMVV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 08:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbTJNMVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 08:21:21 -0400
Received: from dp.samba.org ([66.70.73.150]:58072 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262345AbTJNMVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 08:21:20 -0400
Date: Tue, 14 Oct 2003 22:17:54 +1000
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: mem=16MB laptop testing
Message-ID: <20031014121753.GA610@krispykreme>
References: <20031014105514.GH765@holomorphy.com> <20031014045614.22ea9c4b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031014045614.22ea9c4b.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> hrm.  min_free_kbytes is normally 1024.  I'm surprised that the additional
> 900k made so much difference.  We must be on the hairy edge.
> 
> It looks like we need to precalculate/scale min_free_kbytes, yes?

That would be good for both the low and high end. Id like to see it
default to something larger on my 16GB+ machines.

Anton
