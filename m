Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWCWWE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWCWWE6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 17:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWCWWE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 17:04:58 -0500
Received: from pproxy.gmail.com ([64.233.166.180]:52507 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932190AbWCWWE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 17:04:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=TcMuSt6IN6KoS1oqfLb9s3GYoh8n6mBEsUrGY5A58ai+LM8QnTtuhNtVIB4O2UUTAQbz+PWuw4a8bkuQnWeqxSH7Tz5jm9UZ8sWZ+T4ar+b5jc9hAodak0Cc+H+lCoDFdNEO0Gd1lPPDms7remNzYiDbqKWhCkNL5sX7U9Flea4=
Message-ID: <4421F384.7080500@gmail.com>
Date: Thu, 23 Mar 2006 09:01:56 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.16 PATCH] Connector: Filesystem Events Connector
References: <44216612.3060406@gmail.com> <20060322201432.GA17653@sergelap.austin.ibm.com>
In-Reply-To: <20060322201432.GA17653@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge E. Hallyn wrote:
> Quoting Yi Yang (yang.y.yi@gmail.com):
>   
>> +#ifdef __KERNEL__
>> +#ifdef CONFIG_FS_EVENTS
>> +extern void raise_fsevent(struct dentry * dentryp, u32 mask);
>> +extern void raise_fsevent_move(struct inode * olddir, const char * oldname, 
>> +		struct inode * newdir, const char * newname, u32 mask);
>> +extern void raise_fsevent_create(struct inode * inode, 
>> +		const char * name, u32 mask);
>> +#else
>> +static void raise_fsevent(struct dentry * dentryp,  u32 mask);
>> +{}
>>     
>
> Hmm, this compiles, if !CONFIG_FS_EVENTS?
>   
Sorry for my mistake, thank for your care, I'll resend it to correct it, 
thanks again.
>
> -serge
>
>   

