Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbVJCPFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbVJCPFE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbVJCPFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:05:04 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:59787 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S1751002AbVJCPFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:05:02 -0400
From: David Lang <david.lang@digitalinsight.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Dave Hansen <haveblue@us.ibm.com>,
       Magnus Damm <magnus@valinux.co.jp>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: dlang@dlang.diginsite.com
References: dlang@dlang.diginsite.com
Date: Mon, 3 Oct 2005 08:03:44 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [PATCH 00/07][RFC] i386: NUMA emulation
In-Reply-To: <79580000.1128351582@[10.10.2.4]>
Message-ID: <Pine.LNX.4.62.0510030802090.11541@qynat.qvtvafvgr.pbz>
References: <20050930073232.10631.63786.sendpatchset@cherry.local><1128093825.6145.26.camel@localhost><aec7e5c30510021908la86daf9je0584fb0107f833a@mail.gmail.com><Pine.LNX.4.62.0510030031170.11095@qynat.qvtvafvgr.pbz><aec7e5c30510030302u8186cfer642c7b9337613de@mail.gmail.com>
 <Pine.LNX.4.62.0510030628150.11541@qynat.qvtvafvgr.pbz> <79580000.1128351582@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2005, Martin J. Bligh wrote:

> But that's not the same at all! ;-) PAE memory is the same speed as
> the other stuff. You just have a 3rd level of pagetables for everything.
> One could (correctly) argue it made *all* memory slower, but it does so
> in a uniform fashion.

is it? I've seen during the memory self-test at boot that machines slow 
down noticably as they pass the 4G mark.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
