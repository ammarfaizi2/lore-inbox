Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965135AbVINM2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965135AbVINM2o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 08:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965132AbVINM2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 08:28:44 -0400
Received: from mail.dvmed.net ([216.237.124.58]:22189 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965071AbVINM2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 08:28:43 -0400
Message-ID: <43281775.2060207@pobox.com>
Date: Wed, 14 Sep 2005 08:28:37 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hubert WS Lin <wslin@tw.ibm.com>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, fubar@us.ibm.com,
       donf@us.ibm.com, jklewis@us.ibm.com
Subject: Re: [PATCH 2.6.13] pcnet32: set min ring size to 4
References: <4325298D.1010600@tw.ibm.com>
In-Reply-To: <4325298D.1010600@tw.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubert WS Lin wrote:
> Hi,
> 
> Don Fry reminded me that the pcnet32_loopback_test() asssumes the ring 
> size is no less than 4. The minimum ring size was changed to 4 in 
> pcnet32_set_ringparam() to allow the loopback test to work unchanged.
> 
> Changelog:
> - Set minimum ring size to 4 to allow loopback test to work unchanged
> - Moved variable init_block to first field in struct pcnet32_private
> 
> Signed-off-by: Hubert WS Lin <wslin@tw.ibm.com>

Patch OK, but:

Applying 'pcnet32: set min ring size to 4'

error: patch failed: drivers/net/pcnet32.c:22
error: drivers/net/pcnet32.c: patch does not apply


Please resend, without MIME attachments.

	Jeff


