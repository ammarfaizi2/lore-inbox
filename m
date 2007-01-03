Return-Path: <linux-kernel-owner+w=401wt.eu-S1751623AbXACBOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbXACBOR (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 20:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752742AbXACBOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 20:14:17 -0500
Received: from gate.crashing.org ([63.228.1.57]:55052 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623AbXACBOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 20:14:16 -0500
In-Reply-To: <1167785089.6165.95.camel@localhost.localdomain>
References: <459714A6.4000406@firmworks.com> <Pine.LNX.4.61.0612311350060.32449@yvahk01.tjqt.qr> <20061231.124531.125895122.davem@davemloft.net> <1167709406.6165.6.camel@localhost.localdomain> <b8370fecbb4a917934b0b163ea5774f5@kernel.crashing.org> <1167768494.6165.63.camel@localhost.localdomain> <459ABC7C.2030104@firmworks.com> <1167770882.6165.76.camel@localhost.localdomain> <978466dd510f659cd69b67ee7309be28@kernel.crashing.org> <1167774438.6165.87.camel@localhost.localdomain> <cdda01a9b094a86b24d8d192336f41e2@kernel.crashing.org> <1167785089.6165.95.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <12528f3f1e79ab0f1800b835f98f2a34@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, devel@laptop.org,
       David Miller <davem@davemloft.net>, jengelh@linux01.gwdg.de,
       Mitch Bradley <wmb@firmworks.com>, jg@laptop.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Date: Wed, 3 Jan 2007 02:14:34 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snipping a bit for now]

> It's easier to start merging powerpc and sparc I reckon

Well it won't hurt to merge and clean up these two first, sure.

> and then, "fix"
> that so that it works on x86 :-)

That works, if the goal is to just add x86/OLPC to the list of
platforms that have a device tree fs.  I thought the plan was
to create a single, more generic, OF interface/API in the kernel
though.


Segher

