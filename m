Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWBFQzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWBFQzO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 11:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWBFQzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 11:55:14 -0500
Received: from xenotime.net ([66.160.160.81]:13998 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932219AbWBFQzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 11:55:12 -0500
Date: Mon, 6 Feb 2006 08:55:08 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: David Chow <davidchow@shaolinmicro.com>
cc: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, linux-kernel@vger.kernel.org
Subject: Re: Linux drivers management
In-Reply-To: <43E77E69.8050702@shaolinmicro.com>
Message-ID: <Pine.LNX.4.58.0602060853530.1309@shark.he.net>
References: <43E71AD7.5070600@shaolinmicro.com> <43E71F75.7000605@stud.feec.vutbr.cz>
 <43E77E69.8050702@shaolinmicro.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2006, David Chow wrote:

>
> > Please read Documentation/stable_api_nonsense.txt in your copy of
> > Linux source.
> I've read the document, I strongly disagree, because it is not relavant
> to my question or to my original purpose of this question.
>
> Putting the driver source code in the kernel source tree has nothing to
> do with talking about a stable kernel API . Even you put the driver
> sources into the main kernel tree, it will still need a lot of work to
> port all drivers if the API changes. Driver sources can still host in a
> different project (e.g. projects in sf.net) and maintain open-source and
> om by the community, no difference than before
>
> For different compile time options that affect data structures, this is
> well known a bad idea . These types of techniques no longer allowed in
> Java and other OO languages . Because I can simply say the code is not
> portable. If really need a recompile and optimize, the distro vendor
> should bare this, but according to the document, "As Linux supports a
> larger number of different devices "out of the box" than any other
> operating system" , do you think Linux should one day or some day grow
> to 1TB source tree to include all possible drivers for all hw come from
> the world? I don't see there is reason why a kernel or OS need to
> include all the drivers for all the hardware. I don't think there is any
> OS vendors on the market to capable to distribute all drivers integrity,
> then the choice is to make a disabled Linux OS because of an OSV who has
> only limited supporting resources to suppport and certify limited
> hardware devices.
>
> Please see my other email responded to Jes about the learning curve and
> documentation issues of a Linux driver developer to pick up Linux skills.

Maybe you want something like DKMS from Dell?
  http://linux.dell.com/projects.shtml

or maybe some of the distros have something that fits your needs.

-- 
~Randy
