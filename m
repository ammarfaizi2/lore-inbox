Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbTEUXbJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 19:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbTEUXbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 19:31:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:3545 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262358AbTEUXbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 19:31:08 -0400
Date: Wed, 21 May 2003 16:42:26 -0700 (PDT)
Message-Id: <20030521.164226.23023899.davem@redhat.com>
To: kmannth@us.ibm.com
Cc: zwane@linuxpower.ca, mbligh@aracnet.com, habanero@us.ibm.com,
       haveblue@us.ibm.com, wli@holomorphy.com, arjanv@redhat.com,
       pbadari@us.ibm.com, linux-kernel@vger.kernel.org, gh@us.ibm.com,
       johnstul@us.ltcfwd.linux.ibm, jamesclv@us.ibm.com, akpm@digeo.com
Subject: Re: userspace irq balancerB 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1053560371.19335.4725.camel@dyn9-47-17-180.beaverton.ibm.com>
References: <1053541725.16886.4711.camel@dyn9-47-17-180.beaverton.ibm.com>
	<1053560371.19335.4725.camel@dyn9-47-17-180.beaverton.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Keith Mannthey <kmannth@us.ibm.com>
   Date: 21 May 2003 16:39:29 -0700

     For example a user would have to know that cpus 1,2,9,10 were
   on the same cluster not (1,2,3,4) as you would expect.
   
Nothing prevents us from exporting these mappings to userspace.
Just like we can export a "possible mask" for each interrupt
source.
