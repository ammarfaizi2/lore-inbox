Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWIZFci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWIZFci (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWIZFch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:32:37 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:53728 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751219AbWIZFch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:32:37 -0400
Message-ID: <4518BB6E.5010005@pobox.com>
Date: Tue, 26 Sep 2006 01:32:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Auke Kok <auke-jan.h.kok@intel.com>
CC: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore __iomem annotations in e1000
References: <20060923003240.GF29920@ftp.linux.org.uk> <45186F87.8080207@pobox.com> <4518B451.4080303@intel.com>
In-Reply-To: <4518B451.4080303@intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Auke Kok wrote:
> Jeff Garzik wrote:
>> applied
>>
> 
> Thanks,
> 
> I have no idea why and when these annotations were lost, but we have 
> them in much older versions of the code. I'll try to track it down and 
> make sure that it doesn't disappear again.

Just run an sparse check as described in
Documentation/sparse.txt...

	Jeff


