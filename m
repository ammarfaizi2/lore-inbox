Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWBLRnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWBLRnN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 12:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWBLRnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 12:43:13 -0500
Received: from terminus.zytor.com ([192.83.249.54]:47783 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750763AbWBLRnM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 12:43:12 -0500
Message-ID: <43EF738C.2090109@zytor.com>
Date: Sun, 12 Feb 2006 09:42:36 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       "'austin-group-l@opengroup.org'" <austin-group-l@opengroup.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: The naming of at()s is a difficult matter
References: <43EEACA7.5020109@zytor.com> <Pine.LNX.4.61.0602121137090.25363@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0602121137090.25363@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>I have noticed that the new ...at() system calls are named in what
>>appears to be a completely haphazard fashion.  In Unix system calls,
>>an f- prefix means it operates on a file descriptor; the -at suffix (a
>>prefix would have been more consistent, but oh well) similarly
>>indicates it operates on a (directory fd, pathname) pair.
> 
> shmat operates on dirfd/pathname?
> 

Convention collision.  They unfortunately happen (yet another reason the 
-at convention was ill choosen); another pretty bad clash is the f- 
prefix for use on file descriptors versus use on FILE *...

	-hpa
