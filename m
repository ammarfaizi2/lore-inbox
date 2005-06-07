Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbVFGSQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbVFGSQN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 14:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbVFGSQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 14:16:13 -0400
Received: from dvhart.com ([64.146.134.43]:15528 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261940AbVFGSQM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 14:16:12 -0400
Date: Tue, 07 Jun 2005 11:16:07 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
Subject: Re: 2.6.12?
Message-ID: <971250000.1118168167@flay>
In-Reply-To: <418760000.1117983740@[10.10.2.4]>
References: <42A0D88E.7070406@pobox.com><20050603163843.1cf5045d.akpm@osdl.org><394120000.1117895039@[10.10.2.4]> <20050604151120.46b51901.akpm@osdl.org> <418760000.1117983740@[10.10.2.4]>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --Andrew Morton <akpm@osdl.org> wrote (on Saturday, June 04, 2005 15:11:20 -0700):
> 
>> "Martin J. Bligh" <mbligh@mbligh.org> wrote:
>>> 
>>> The one that worries me is that my x86_64 box won't boot since -rc3
>>>  See:
>>> 
>>>  http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/regression_matrix.html

HA. Found it. binary search reveals it's patch 182 out of 2.6.12-rc2-mm2.
And the winner is .... <drum roll please> ....

x86_64-use-the-e820-hole-to-map-the-iommu-agp-aperture.patch

me no likey! ;-)

M.

