Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964933AbVHOUPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbVHOUPF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 16:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbVHOUPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 16:15:04 -0400
Received: from mailhub.lss.emc.com ([168.159.2.31]:48531 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S964933AbVHOUPD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 16:15:03 -0400
Message-ID: <4300F846.8030404@emc.com>
Date: Mon, 15 Aug 2005 16:17:10 -0400
From: Brett Russ <russb@emc.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2.6.13-rc6] PCI/libata INTx cleanup
References: <20050803204709.8BA0720B06@lns1058.lss.emc.com> <42FBA08C.5040103@pobox.com> <20050812171043.CF61020E8B@lns1058.lss.emc.com> <20050812182253.GA7842@suse.de> <42FD14E9.8060502@pobox.com> <20050812224303.F40A820E94@lns1058.lss.emc.com> <20050815185732.GA15216@kroah.com> <4300E83F.1090401@emc.com> <20050815200637.GA15871@kroah.com>
In-Reply-To: <20050815200637.GA15871@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.8.15.24
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='EMC_FROM_00+ -0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
>>Hmm, I did build it before submitting, saw not even a warning.  So I 
>>just rebuilt it again to verify, and same thing.  Why would my tree work 
>>and not yours?  config file?
> 
> 
> You don't have MSI enabled in yours :(

Yup, you're right.  Sorry about that.  The patch I sent @15:23 today 
should be all set now.

BR
