Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964912AbVIMRUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbVIMRUA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 13:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbVIMRT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 13:19:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49117 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964905AbVIMRT6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 13:19:58 -0400
Date: Mon, 12 Sep 2005 19:27:35 -0400
From: Dave Jones <davej@redhat.com>
To: Jim McCloskey <mcclosk@ucsc.edu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PROBLEM] mtrr's not set, 2.6.13
Message-ID: <20050912232735.GB1011@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jim McCloskey <mcclosk@ucsc.edu>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Shaohua Li <shaohua.li@intel.com>
References: <20050912091021.GA2859@branci40> <20050912025120.4016c36b.akpm@osdl.org> <20050912172426.GA2882@branci40>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050912172426.GA2882@branci40>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 10:24:26AM -0700, Jim McCloskey wrote:

 > /proc/mtrr:
 > 
 > reg00: base=0x00000000 (   0MB), size=983552MB: write-back, count=1

That's an incredibly huge amount of system ram :)
Have you done a BIOS update between the kernel upgrades by any chance ?
Or altered any options in the BIOS ?

Does booting the older kernel definitly still work ?

AFAIR, we don't touch the first MTRR, that's typically set up
by the BIOS before we even boot.

		Dave

