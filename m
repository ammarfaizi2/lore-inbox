Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbWC1MsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWC1MsU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 07:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWC1MsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 07:48:20 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:15312 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1750737AbWC1MsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 07:48:19 -0500
In-Reply-To: <200603281028.25627.ncunningham@cyclades.com>
References: <200603211133.AA00855@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <200603272357.AA00920@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <200603281028.25627.ncunningham@cyclades.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8c956d57936a14bf8f473a698dbfa63c@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
       Jim Crilly <jim@why.dont.jablowme.net>,
       suspend2-devel@lists.suspend2.net,
       Jun OKAJIMA <okajima@digitalinfra.co.jp>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [Xen-devel] Re: Fwd: Faster resuming of suspend technology.
Date: Tue, 28 Mar 2006 13:48:37 +0100
To: Nigel Cunningham <ncunningham@cyclades.com>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 28 Mar 2006, at 01:28, Nigel Cunningham wrote:

>> I think it must have and you can use the same suspend image on all 
>> Xen PCs.
>
> Yeah.

Certain CPU features can screw things up. So moving from a CPU that 
supports SSE2 to one that doesn't is unlikely to work well, for 
example. But as long as CPU capabilities are a reasonably close match 
then yes, you should be able to use a suspend image anywhere.

  -- Keir

