Return-Path: <linux-kernel-owner+w=401wt.eu-S932793AbXASAlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932793AbXASAlp (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 19:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932799AbXASAlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 19:41:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:36236 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932793AbXASAlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 19:41:44 -0500
From: Andi Kleen <ak@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] rdmsr_on_cpu, wrmsr_on_cpu
Date: Fri, 19 Jan 2007 11:40:58 +1100
User-Agent: KMail/1.9.1
Cc: Alexey Dobriyan <adobriyan@openvz.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
       devel@vger.kernel.org
References: <20070118144527.GA6021@localhost.sw.ru> <200701191021.16706.ak@suse.de> <45B00588.3010207@zytor.com>
In-Reply-To: <45B00588.3010207@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701191140.59612.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 January 2007 10:40, H. Peter Anvin wrote:

> It would, but rather than having the paravirtualization interfaces
> duplicate out of control, we could/should implement the less generic
> features in terms of the more generic, above the pvz layer.

I can't see any Hypervisors ever allowing those weird MSRs, so
for paravirtualization it is probably better to just disable then.

-Andi
