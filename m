Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313274AbSC1Wtw>; Thu, 28 Mar 2002 17:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313276AbSC1Wtn>; Thu, 28 Mar 2002 17:49:43 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:57303 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S313274AbSC1Wt1>; Thu, 28 Mar 2002 17:49:27 -0500
Date: Thu, 28 Mar 2002 14:48:37 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Arjan van de Ven <arjanv@redhat.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Testing of Ingo/Arjan highpte on 16-way NUMA-Q
Message-ID: <162960000.1017355717@flay>
In-Reply-To: <20020326191814.F13052@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adding your highpte patches to the NUMA-Q seems to make no
performance impact whatsoever (just doing kernel compile). The
profiles are so similar, it almost looks like it's not doing anything at
all ;-) I find this a little strange, as all my ZONE_NORMAL is on
node 0, so I'd expected this to have some sort of impact (either 
positive or negative ;-)). 

Is there an easy way to test whether this was working or not?

Thanks,

M.

PS. yes I did remember to turn on the 4G-highpte option ;-)



