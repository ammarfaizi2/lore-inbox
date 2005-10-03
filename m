Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbVJCPql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbVJCPql (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbVJCPql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:46:41 -0400
Received: from geryon.wsm.com ([12.163.128.2]:11454 "EHLO geryon.wsm.com")
	by vger.kernel.org with ESMTP id S932282AbVJCPqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:46:40 -0400
Message-ID: <43415265.7000908@wsm.com>
Date: Mon, 03 Oct 2005 08:46:45 -0700
From: Jeff Johnson <jeff.johnson@wsm.com>
Organization: Western Scientific, Inc
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: "Kernel panic: VRKADINT" under heavy I/O.  What is the source or
 location of VRKADINT
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scan-Signature: 3c1be6617017a38cff1032ecd9727baf
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

    I have several systems that will hang under heavy i/o. This usually 
occurs during a Pallas AllToAll test over Infiniband. Is anyone able to 
point me to where I can find VRKADINT or what general area of the kernel 
this is coming from? Everything runs fine otherwise. When I start the 
AllToAll across 32 machines and get 128 cores all talking to each other 
at once random machines will panic with the VRKADINT. I cannot seem to 
find this message anywhere in kernel source.

details:
arch   x86_64
kernel  2.6.5-7.193-smp (SuSE Ent9)
proc  2x dual core Opteron 275
ram 16GB

--Jeff
