Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbUJ0DUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbUJ0DUe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 23:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbUJ0DUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 23:20:34 -0400
Received: from cantor.suse.de ([195.135.220.2]:10683 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261619AbUJ0DUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 23:20:19 -0400
Date: Wed, 27 Oct 2004 05:18:19 +0200
From: Andi Kleen <ak@suse.de>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: akpm@osdl.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add p4-clockmod driver in x86-64
Message-ID: <20041027031819.GC768@wotan.suse.de>
References: <20041026142826.A24417@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041026142826.A24417@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 02:28:26PM -0700, Venkatesh Pallipadi wrote:
> 
> Add links for p4-clockmod driver in x86-64 cpufreq. 

Does this really make sense? I thought all shipping EM64T capable CPUs
supported DBS?  Why would you want clock modulation when you have DBS?

My own experience is that the clockmod driver is not very usable,
it leads to extensive delays on a graphical desktop.

-Andi

