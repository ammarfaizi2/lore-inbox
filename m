Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266841AbUFYSuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266841AbUFYSuQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 14:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266838AbUFYStM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 14:49:12 -0400
Received: from fujitsu1.fujitsu.com ([192.240.0.1]:60629 "EHLO
	fujitsu1.fujitsu.com") by vger.kernel.org with ESMTP
	id S266839AbUFYSsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 14:48:30 -0400
Date: Fri, 25 Jun 2004 11:48:07 -0700
From: Yasunori Goto <ygoto@us.fujitsu.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [Lhms-devel] Re: Merging Nonlinear and Numa style memory hotplug
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>,
       Linux-Node-Hotplug <lhns-devel@lists.sourceforge.net>,
       linux-mm <linux-mm@kvack.org>,
       "BRADLEY CHRISTIANSEN [imap]" <bradc1@us.ibm.com>
In-Reply-To: <1088133541.3918.1348.camel@nighthawk>
References: <20040624194557.F02B.YGOTO@us.fujitsu.com> <1088133541.3918.1348.camel@nighthawk>
Message-Id: <20040625114720.2935.YGOTO@us.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.07.02
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > Should this translation be in common code?
> 
> What do you mean by common code?  It should be shared by all
> architectures.

If physical memory chunk size is larger than the area which
should be contiguous like IA32's kmalloc, 
there is no merit in this code.
So, I thought only mem_section is enough.
But I don't know about other architecutures yet and I'm not sure.

Are you sure that all architectures need phys_section?

Bye.
-- 
Yasunori Goto <ygoto at us.fujitsu.com>


