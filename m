Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbVHKRq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbVHKRq1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 13:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbVHKRq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 13:46:27 -0400
Received: from fsmlabs.com ([168.103.115.128]:40321 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S932316AbVHKRq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 13:46:26 -0400
Date: Thu, 11 Aug 2005 11:52:08 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
cc: jamesclv@us.ibm.com, Andi Kleen <ak@suse.de>,
       "Brown, Len" <len.brown@intel.com>, linux-kernel@vger.kernel.org
Subject: RE: [RFC][2.6.12.3] IRQ compression/sharing patch
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04CAE@USRV-EXCH4.na.uis.unisys.com>
Message-ID: <Pine.LNX.4.61.0508111149190.14504@montezuma.fsmlabs.com>
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04CAE@USRV-EXCH4.na.uis.unisys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2005, Protasevich, Natalie wrote:

> our systems we are just about to use up all 224 interrupts, but not
> quiet. 
> I have to mention that as far as I know Zwane is about to release his
> vector sharing mechanism, he had it implemented and working for i386 (I
> tested it on ES7000 successfully, by itself and combined with
> compression patch too), and was planning implementing it for x86_64. I
> am officially volunteering for testing it in its present state, for both
> i386 and x86_64 (I can still do this on our systems by removing the IRQ
> compression code :), hope this will help Zwane and Andi to release it as
> soon as possible.

I added some of the suggestions brought forward (dynamically allocated 
IDTs, percpu IDT) last night, all that's left is MSI, which does work 
right now, but gets all its vectors allocated on the first irq handling 
domain. I should be done soon, time permitting.

Thanks,
	Zwane

