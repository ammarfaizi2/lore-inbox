Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWBMP5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWBMP5Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 10:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWBMP5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 10:57:24 -0500
Received: from terminus.zytor.com ([192.83.249.54]:36258 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750745AbWBMP5Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 10:57:24 -0500
Message-ID: <43F0AC39.3080007@zytor.com>
Date: Mon, 13 Feb 2006 07:56:41 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
CC: jengelh@linux01.gwdg.de, linux-kernel@vger.kernel.org, drepper@redhat.com,
       austin-group-l@opengroup.org
Subject: Re: The naming of at()s is a difficult matter
References: <43EEACA7.5020109@zytor.com> <Pine.LNX.4.61.0602121137090.25363@yvahk01.tjqt.qr> <43F09320.nailKUSI1GXEI@burner>
In-Reply-To: <43F09320.nailKUSI1GXEI@burner>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:
> Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> 
> 
>>>I have noticed that the new ...at() system calls are named in what
>>>appears to be a completely haphazard fashion.  In Unix system calls,
>>>an f- prefix means it operates on a file descriptor; the -at suffix (a
>>>prefix would have been more consistent, but oh well) similarly
>>>indicates it operates on a (directory fd, pathname) pair.
>>>
>>
>>shmat operates on dirfd/pathname?
> 
> 
> Do you have a better proposal for naming the interfaces?
> 

Isn't it obvious?  Drop the misleading f- prefixes.

	-hpa
