Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbTEVWf0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 18:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263373AbTEVWf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 18:35:26 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:20400 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263365AbTEVWfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 18:35:17 -0400
Subject: Re: [PATCH] 1/2 Add exposure of the irq delivery mask on x86
From: Keith Mannthey <kmannth@us.ibm.com>
To: James.Bottomley@steeleye.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 May 2003 15:50:35 -0700
Message-Id: <1053643837.19335.4816.camel@dyn9-47-17-180.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>This exposes a delivery mask in /proc/<irq>/mask for the userspace irq
>>balancer to use in its calculations.

  What exactly are you trying to expose? These patches look to just show
what cpus are on-line.  Wouldn't this just be the cpu_online_map in all
cases?  I guess I am a little confuses by what a "delivery mask" is.

Thanks,  
  Keith  


