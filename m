Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWCVJ3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWCVJ3a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 04:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWCVJ3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 04:29:30 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:1484 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1751159AbWCVJ33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 04:29:29 -0500
In-Reply-To: <1143016996.2955.24.camel@laptopd505.fenrus.org>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063804.956561000@sorel.sous-sol.org> <1143016996.2955.24.camel@laptopd505.fenrus.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <bc0c4e54904884203c173fbc9558ec65@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 29/35] Add the Xen virtual console driver.
Date: Wed, 22 Mar 2006 09:29:48 +0000
To: Arjan van de Ven <arjan@infradead.org>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22 Mar 2006, at 08:43, Arjan van de Ven wrote:

>> This provides a bootstrap and ongoing emergency console which is
>> intended to be available from very early during boot and at all times
>> thereafter, in contrast with alternatives such as UDP-based syslogd,
>> or logging in via ssh. The protocol is based on a simple shared-memory
>> ring buffer.
>
> there already exist early consoles. Please just use that infrastructure
> instead.

By 'early console' I don't mean it's an alternative to the early_printk 
infrastructure. It's simply an easy way to characters out of the guest 
when other alternatives (such as using the virtual network device) are 
unusable.

  -- Keir

