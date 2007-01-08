Return-Path: <linux-kernel-owner+w=401wt.eu-S1422635AbXAHSVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422635AbXAHSVg (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 13:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422705AbXAHSVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 13:21:36 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:54390 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1422635AbXAHSVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 13:21:35 -0500
Date: Mon, 8 Jan 2007 10:18:34 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Pavel Machek <pavel@ucw.cz>
cc: Ingo Molnar <mingo@elte.hu>, kvm-devel <kvm-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Avi Kivity <avi@qumranet.com>
Subject: Re: [announce] [patch] KVM paravirtualization for Linux
In-Reply-To: <20070106130817.GB5660@ucw.cz>
Message-ID: <Pine.LNX.4.64.0701081016140.9173@schroedinger.engr.sgi.com>
References: <20070105215223.GA5361@elte.hu> <20070106130817.GB5660@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jan 2007, Pavel Machek wrote:

> Does this make Xen obsolete? I mean... we have xen patches in suse
> kernels, should we keep updating them, or just drop them in favour of
> KVM?
> 							Pavel

Xen is duplicating basic OS components like the scheduler etc. As 
a result its difficult to maintain and not well integrated with Linux. 
KVM looks like a better approach.


