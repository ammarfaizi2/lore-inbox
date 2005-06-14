Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVFNRLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVFNRLg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 13:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVFNRLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 13:11:36 -0400
Received: from mail2.utc.com ([192.249.46.191]:40885 "EHLO mail2.utc.com")
	by vger.kernel.org with ESMTP id S261259AbVFNRLe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 13:11:34 -0400
Message-ID: <42AF0FA2.2050407@cybsft.com>
Date: Tue, 14 Jun 2005 12:10:58 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve Lord <lord@xfs.org>
CC: Andrew Morton <akpm@osdl.org>, pozsy@uhulinux.hu,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: Race condition in module load causing undefined symbols
References: <42A99D9D.7080900@xfs.org>	<20050610112515.691dcb6e.akpm@osdl.org>	<20050611082642.GB17639@ojjektum.uhulinux.hu>	<42AAE5C8.9060609@xfs.org>	<20050611150525.GI17639@ojjektum.uhulinux.hu>	<42AB25E7.5000405@xfs.org> <20050611120040.084942ed.akpm@osdl.org> <42AEDCFB.8080002@xfs.org> <42AEF979.2000207@cybsft.com> <42AF080A.1000307@xfs.org>
In-Reply-To: <42AF080A.1000307@xfs.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lord wrote:
<snip>
> So is this some P4 specific optimization which is not working as
> intended?
> 
> Steve
> 
> 

I'd say not since the first system I saw this on was a dual PIII Xeon. 
While I am not 100% sure that the problems are related, the problem that 
I saw on my 2.6 system also went away when I disabled hyper-threading in 
the bios. It really just seems to me like it is some hard-to-trigger race.

-- 
    kr
