Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264269AbUE2L4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264269AbUE2L4z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 07:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264283AbUE2L4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 07:56:55 -0400
Received: from tristate.vision.ee ([194.204.30.144]:44262 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S264269AbUE2L4x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 07:56:53 -0400
Message-ID: <40B87A83.1020208@vision.ee>
Date: Sat, 29 May 2004 14:56:51 +0300
From: =?ISO-8859-1?Q?Lenar_L=F5hmus?= <lenar@vision.ee>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040509)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tomas Szepe <szepe@pinerecords.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: filesystem corruption (ReiserFS, 2.6.6): regions replaced by
 \000 bytes
References: <20040528122854.GA23491@clipper.ens.fr> <1085748363.22636.3102.camel@watt.suse.com> <20040528162450.GE422@louise.pinerecords.com>
In-Reply-To: <20040528162450.GE422@louise.pinerecords.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Szepe wrote:

>On May-28 2004, Fri, 08:46 -0400
>Chris Mason <mason@suse.com> wrote:
>
>  
>
>>>The bottom line: I've experienced file corruption, of the following
>>>nature: consecutive regions (all, it seems, aligned on 256-byte
>>>boundaries, and typically around 1kb or 2kb in length) of seemingly
>>>random files are replaced by null bytes.  
>>>      
>>>
>>The good news is that we tracked this one down recently.  2.6.7-rc1
>>shouldn't do this anymore.
>>    
>>
>
>So did this only affect SMP machines?
>
>  
>
No, it's UP here. And I think it happened first with 2.6.6-rc2-mm2.

Lenar
