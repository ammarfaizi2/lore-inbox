Return-Path: <linux-kernel-owner+w=401wt.eu-S1751157AbXACAvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbXACAvr (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 19:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752486AbXACAvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 19:51:47 -0500
Received: from gate.crashing.org ([63.228.1.57]:36978 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751157AbXACAvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 19:51:46 -0500
In-Reply-To: <20070102.140749.104035927.davem@davemloft.net>
References: <459ABC7C.2030104@firmworks.com> <1167770882.6165.76.camel@localhost.localdomain> <978466dd510f659cd69b67ee7309be28@kernel.crashing.org> <20070102.140749.104035927.davem@davemloft.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3676953abedcbe6d86da74a4997593cb@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, devel@laptop.org, jengelh@linux01.gwdg.de,
       benh@kernel.crashing.org, wmb@firmworks.com, jg@laptop.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Date: Wed, 3 Jan 2007 01:52:06 +0100
To: David Miller <davem@davemloft.net>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Leaving aside the issue of in-memory or not, I don't think
>> it is realistic to think any completely common implementation
>> will work for this -- it might for current SPARC+PowerPC+OLPC,
>> but more stuff will be added over time...
>
> I see nothing supporting this IMHO bogus claim.

Please keep in mind that not all systems want to kill OF
as soon as they enter the kernel -- some want to keep it
active basically forever (or only remove it when the user
asks for it).


Segher

