Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbTIQACL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 20:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262583AbTIQACL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 20:02:11 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:12162
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262569AbTIQACI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 20:02:08 -0400
Date: Tue, 16 Sep 2003 20:02:04 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andi Kleen <ak@suse.de>
cc: "Nakajima, Jun" <jun.nakajima@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Options for handling  buggy PCI/PCI-X hardware when MSI is
 enabled
In-Reply-To: <p73ekygnvq5.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.53.0309162000440.23370@montezuma.fsmlabs.com>
References: <7F740D512C7C1046AB53446D3720017304AF60@scsmsx402.sc.intel.com.suse.lists.linux.kernel>
 <p73ekygnvq5.fsf@oldwotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2003, Andi Kleen wrote:

> And worse one has to submit patches for the core kernel all the time.
> And it's a single table, which means there will be lots of conflicts 
> when merging patches.
> 
> I think the new API approach is much better. Best would be if there
> was a relatively simple standard way to add it to drivers  (like a 
> standard module option). Then one could add it to a lot of drivers 
> with default to off. Users can test then and if it works the default
> can be changed.

Just to add another point for the per driver/new API approach, you can 
debug on a per device basis much easier whilst having MSI functioning on 
other devices.

	Zwane

