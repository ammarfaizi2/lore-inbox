Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161455AbWJSPZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161455AbWJSPZp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 11:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161456AbWJSPZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 11:25:45 -0400
Received: from mxsf09.cluster1.charter.net ([209.225.28.209]:17901 "EHLO
	mxsf09.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1161455AbWJSPZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 11:25:44 -0400
X-IronPort-AV: i="4.09,330,1157342400"; 
   d="scan'208"; a="216137778:sNHT19841148"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17719.39146.785414.179384@smtp.charter.net>
Date: Thu, 19 Oct 2006 11:25:30 -0400
From: "John Stoffel" <john@stoffel.org>
To: Avi Kivity <avi@qumranet.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, John Stoffel <john@stoffel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] KVM: userspace interface
In-Reply-To: <453790EC.8080008@qumranet.com>
References: <4537818D.4060204@qumranet.com>
	<453781F9.3050703@qumranet.com>
	<17719.35854.477605.398170@smtp.charter.net>
	<1161269405.17335.80.camel@localhost.localdomain>
	<453790EC.8080008@qumranet.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Avi> Alan Cox wrote:
>> Ar Iau, 2006-10-19 am 10:30 -0400, ysgrifennodd John Stoffel:
>> 
>>> Yuck.  ioclts are deprecated, you should be using /sysfs instead for
>>> stuff like this, or configfs.  
>> 
>> Making sure the ioctl sizes are the same in 32/64bit and aligned the
>> same way is the more important issue.
>> 

Avi> Yes, pointers are padded and all other types are explicitly sized.  
Avi> Alignment is always natural.

My apologies, I should have kept my mouth shut.  :]  Looks interesting
for sure.

John
