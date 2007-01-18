Return-Path: <linux-kernel-owner+w=401wt.eu-S1751993AbXARLAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbXARLAs (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 06:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbXARLAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 06:00:48 -0500
Received: from codepoet.org ([166.70.99.138]:37694 "EHLO codepoet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993AbXARLAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 06:00:47 -0500
Date: Thu, 18 Jan 2007 04:00:28 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Andi Kleen <ak@suse.de>
Cc: Chris Wedgwood <cw@f00f.org>,
       Christoph Anton Mitterer <calestyo@scientia.net>,
       Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org,
       knweiss@gmx.de, krader@us.ibm.com, lfriedman@nvidia.com,
       linux-nforce-bugs@nvidia.com
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives (k8 cpu errata needed?)
Message-ID: <20070118110028.GA22407@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org, Andi Kleen <ak@suse.de>,
	Chris Wedgwood <cw@f00f.org>,
	Christoph Anton Mitterer <calestyo@scientia.net>,
	Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org,
	knweiss@gmx.de, krader@us.ibm.com, lfriedman@nvidia.com,
	linux-nforce-bugs@nvidia.com
References: <fa.E9jVXDLMKzMZNCbslzUxjMhsInE@ifi.uio.no> <45AD2D00.2040904@scientia.net> <20070116203143.GA4213@tuatara.stupidest.org> <200701170829.54540.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701170829.54540.ak@suse.de>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Jan 17, 2007 at 08:29:53AM +1100, Andi Kleen wrote:
> AMD is looking at the issue. Only Nvidia chipsets seem to be affected,
> although there were similar problems on VIA in the past too.
> Unless a good workaround comes around soon I'll probably default
> to iommu=soft on Nvidia.

I just tried again and while using iommu=soft does avoid the
corruption problem, as with previous kernels with 2.6.20-rc5
using iommu=soft still makes my pcHDTV HD5500 DVB cards not work.
I still have to disable memhole and lose 1 GB.  :-(

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
