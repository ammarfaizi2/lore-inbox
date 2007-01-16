Return-Path: <linux-kernel-owner+w=401wt.eu-S1751409AbXAPVcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbXAPVcS (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 16:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbXAPVcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 16:32:18 -0500
Received: from ns.suse.de ([195.135.220.2]:33291 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409AbXAPVcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 16:32:17 -0500
From: Andi Kleen <ak@suse.de>
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives (k8 cpu errata needed?)
Date: Wed, 17 Jan 2007 08:29:53 +1100
User-Agent: KMail/1.9.1
Cc: Christoph Anton Mitterer <calestyo@scientia.net>,
       Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org,
       knweiss@gmx.de, andersen@codepoet.org, krader@us.ibm.com,
       lfriedman@nvidia.com, linux-nforce-bugs@nvidia.com
References: <fa.E9jVXDLMKzMZNCbslzUxjMhsInE@ifi.uio.no> <45AD2D00.2040904@scientia.net> <20070116203143.GA4213@tuatara.stupidest.org>
In-Reply-To: <20070116203143.GA4213@tuatara.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701170829.54540.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 January 2007 07:31, Chris Wedgwood wrote:
> On Tue, Jan 16, 2007 at 08:52:32PM +0100, Christoph Anton Mitterer wrote:
> > I agree,... it seems drastic, but this is the only really secure
> > solution.
>
> I'd like to here from Andi how he feels about this?  It seems like a
> somewhat drastic solution in some ways given a lot of hardware doesn't
> seem to be affected (or maybe in those cases it's just really hard to
> hit, I don't know).

AMD is looking at the issue. Only Nvidia chipsets seem to be affected,
although there were similar problems on VIA in the past too.
Unless a good workaround comes around soon I'll probably default
to iommu=soft on Nvidia.

-Andi
