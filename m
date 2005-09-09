Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965265AbVIIGHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965265AbVIIGHN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 02:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965266AbVIIGHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 02:07:12 -0400
Received: from mx1.suse.de ([195.135.220.2]:4328 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965265AbVIIGHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 02:07:11 -0400
From: Andi Kleen <ak@suse.de>
To: Piter PUNK <piterpk@terra.com.br>,
       Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 2.6.13] x86: check host bridge when applying vendor quirks
Date: Fri, 9 Sep 2005 08:07:03 +0200
User-Agent: KMail/1.8
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200509082236_MC3-1-A99D-81DD@compuserve.com> <200509090447.10118.ak@suse.de> <43211B67.30607@terra.com.br>
In-Reply-To: <43211B67.30607@terra.com.br>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509090807.04074.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 September 2005 07:19, Piter PUNK wrote:

> Hmmm... no.

Yes. e.g. the Machines with AMD 8111 or Nvidia chipsets don't have another 
Hostbridge.

>> root@Weasley:/etc# lspci
> 00:00.0 Host bridge: ATI Technologies Inc: Unknown device 5950
> <...many things...>
> 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> HyperTransport Technology Configuration
> 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> Address Map
> 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> DRAM Controller
> 00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> Miscellaneous Control
>
> The Athlon64 machines has an external host bridge. You can look the
> ATI Host Bridge in the first line of lspci.

Maybe your ATI chipset, but not in general.

-Andi
