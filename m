Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbVC2C7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbVC2C7w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 21:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbVC2C7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 21:59:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31921 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262163AbVC2C7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 21:59:45 -0500
Date: Mon, 28 Mar 2005 21:59:32 -0500
From: Dave Jones <davej@redhat.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] optimization: defer bio_vec deallocation
Message-ID: <20050329025932.GC435@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>, axboe@suse.de,
	linux-kernel@vger.kernel.org
References: <200503290238.j2T2cQg25626@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503290238.j2T2cQg25626@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 06:38:23PM -0800, Chen, Kenneth W wrote:
 > We have measured that the following patch give measurable performance gain
 > for industry standard db benchmark.  Comments?

If you can't publish results from that certain benchmark due its stupid
restrictions, could you also try running an alternative benchmark that
you can show results from ?

These nebulous claims of 'measurable gains' could mean anything.
I'm assuming you see a substantial increase in throughput, but
how much is it worth in exchange for complicating the code?

		Dave


