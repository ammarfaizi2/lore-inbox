Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWEOHJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWEOHJD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 03:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWEOHJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 03:09:03 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:33487 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S932363AbWEOHJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 03:09:01 -0400
In-Reply-To: <20060514234418.65656de9.zaitcev@redhat.com>
References: <20060509084945.373541000@sous-sol.org> <20060509085151.047254000@sous-sol.org> <20060514234418.65656de9.zaitcev@redhat.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <51273edbbdeaa63ae4c93fff92332780@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: virtualization@lists.osdl.org, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com, ian.pratt@xensource.com,
       Chris Wright <chrisw@sous-sol.org>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 08/35] Add Xen-specific memory management definitions
Date: Mon, 15 May 2006 08:04:21 +0100
To: Pete Zaitcev <zaitcev@redhat.com>
X-Mailer: Apple Mail (2.624)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 15 May 2006, at 07:44, Pete Zaitcev wrote:

> I'm sure you considered this, but decided to be tricky. Why?
> No way to find the safe number of machine pages in a guest?

We want to allow holes in the table if RAM is sparse. That code 
shouldn't ever fail after the guest has installed a page-fault handler. 
If you can make it do so (was it i386 or x86/64?) we're interested in 
seeing the full crash output.

  -- Keir

