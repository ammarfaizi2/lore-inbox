Return-Path: <linux-kernel-owner+w=401wt.eu-S932433AbXARQg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbXARQg0 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 11:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbXARQg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 11:36:26 -0500
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:36877 "HELO
	smtp106.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932433AbXARQgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 11:36:25 -0500
X-YMail-OSG: Y4bpEWoVM1mFW0hEPsT010LUkqYK33_RjumMCDa14CN9CkAY.HBdO.5whDeJ1n08o_9lAYx2RnMxJKCZzALUQh5rmkVvYyuMAOoejb1riYDPZtQeKaIRmt4NvONpx5h50JRC0rtWcpdyoA4-
Date: Thu, 18 Jan 2007 08:36:21 -0800
From: Chris Wedgwood <cw@f00f.org>
To: andersen@codepoet.org, Andi Kleen <ak@suse.de>,
       Christoph Anton Mitterer <calestyo@scientia.net>,
       Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org,
       knweiss@gmx.de, krader@us.ibm.com, lfriedman@nvidia.com,
       linux-nforce-bugs@nvidia.com
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives (k8 cpu errata needed?)
Message-ID: <20070118163621.GA27305@tuatara.stupidest.org>
References: <fa.E9jVXDLMKzMZNCbslzUxjMhsInE@ifi.uio.no> <45AD2D00.2040904@scientia.net> <20070116203143.GA4213@tuatara.stupidest.org> <200701170829.54540.ak@suse.de> <20070118110028.GA22407@codepoet.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070118110028.GA22407@codepoet.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2007 at 04:00:28AM -0700, Erik Andersen wrote:

> I just tried again and while using iommu=soft does avoid the
> corruption problem, as with previous kernels with 2.6.20-rc5 using
> iommu=soft still makes my pcHDTV HD5500 DVB cards not work.

i would file a separate bug about that, presumably it won't work in
intel based machines too if the driver has dma api bugs

