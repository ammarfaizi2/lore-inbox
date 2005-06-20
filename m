Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVFTQwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVFTQwf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 12:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVFTQwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 12:52:14 -0400
Received: from 64-60-250-34.cust.telepacific.net ([64.60.250.34]:56469 "EHLO
	panta-1.pantasys.com") by vger.kernel.org with ESMTP
	id S261400AbVFTQvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 12:51:39 -0400
Message-ID: <42B6F41A.1030605@pantasys.com>
Date: Mon, 20 Jun 2005 09:51:38 -0700
From: Peter Buckingham <peter@pantasys.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
CC: sean.bruno@dsl-only.net, koch@esa.informatik.tu-darmstadt.de,
       torvalds@osdl.org, benh@kernel.crashing.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
References: <Pine.LNX.4.58.0506091617130.2286@ppc970.osdl.org> <20050610184815.A13999@jurassic.park.msu.ru> <200506102247.30842.koch@esa.informatik.tu-darmstadt.de> <1118762382.9161.3.camel@home-lap> <20050616142039.GF21542@erebor.esa.informatik.tu-darmstadt.de> <42B1B4D3.3060600@pantasys.com> <1118955201.10529.10.camel@home-lap> <42B1E9B2.30504@pantasys.com> <20050617135400.A32290@jurassic.park.msu.ru> <20050617093410.24a58d56.peter@pantasys.com> <20050618114531.A2523@jurassic.park.msu.ru>
In-Reply-To: <20050618114531.A2523@jurassic.park.msu.ru>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Jun 2005 16:48:59.0156 (UTC) FILETIME=[F4821D40:01C575B7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,

Ivan Kokshaysky wrote:
> On Fri, Jun 17, 2005 at 09:34:10AM -0700, Peter Buckingham wrote:
> 
>>PCI: Cannot allocate resource region 2 of device 0000:41:00.0
>>PCI: Failed to allocate mem resource #0:1000000@280000000 for 0000:41:00.0
>>PCI: Failed to allocate mem resource #1:10000000@280000000 for 0000:41:00.0
>>PCI: Failed to allocate mem resource #2:1000000@280000000 for 0000:41:00.0
> 
> 						  ^^^^^^^^^
> 
> Ouch. We managed to get value > 4G from 32-bit BARs.
> Must be a bug somewhere in PCI probing code...

sorry, for the delayed reply..

can you give some suggestions (ie .c files or functions) that would be 
useful to start looking at to track this down?

thanks!

peter
