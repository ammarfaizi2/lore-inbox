Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVFTN06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVFTN06 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 09:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVFTN06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 09:26:58 -0400
Received: from crl-mail-dmz.crl.hpl.hp.com ([192.58.210.9]:5358 "EHLO
	crl-mailb.crl.dec.com") by vger.kernel.org with ESMTP
	id S261217AbVFTN04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 09:26:56 -0400
Message-ID: <42B6C3FD.5050808@hp.com>
Date: Mon, 20 Jun 2005 09:26:21 -0400
From: Jamey Hicks <jamey.hicks@hp.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: recursive call to platform_device_register deadlocks
References: <42B43226.20703@hp.com> <20050619055924.GA14674@kroah.com>
In-Reply-To: <20050619055924.GA14674@kroah.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-HPLC-MailScanner-Information: Please contact the ISP for more information
X-HPLC-MailScanner: Found to be clean
X-HPLC-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (score=-4.9, required 5, BAYES_00 -4.90)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Sat, Jun 18, 2005 at 10:39:34AM -0400, Jamey Hicks wrote:
>  
>
>>We could restructure the toplevel driver so that it does not call 
>>platform_device inside its probe function.  An alternative would be to 
>>add a pointer to a vector of subdevices to platform_device and have it 
>>register the subdevices after it has probed the toplevel device.  Do you 
>>have any recommendations?
>>    
>>
>
>Use the -mm kernel, this should be allowed in that release, due to a
>rework of the driver core logic in this area.  Can you test this out and
>verify this?
>
>  
>
Sounds good.  I will test it out.

Jamey

