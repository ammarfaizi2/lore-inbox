Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263126AbUFBPKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbUFBPKL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 11:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbUFBPKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 11:10:11 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:26197 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263126AbUFBPKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 11:10:07 -0400
Message-ID: <40BDEDF6.1030405@yahoo.fr>
Date: Wed, 02 Jun 2004 17:10:46 +0200
From: Eric BEGOT <eric_begot@yahoo.fr>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Manu Abraham <manu@kromtek.com>, linux-kernel@vger.kernel.org
Subject: Re: Minor numbers under 2.6
References: <200406021519.32128.manu@kromtek.com> <20040602144931.GA25424@kroah.com>
In-Reply-To: <20040602144931.GA25424@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>The same way:
>	# mknod foo c 100 10000
>	# ls -l foo 
>	crw-r--r--  1 root root 100, 10000 Jun  2 07:48 foo
>
>
>  
>
Under 2.6.7-rc2-mm1 :
root@Starbuck:/home/tyler>mknod /dev/test c 100 1000
root@Starbuck:/home/tyler>ll /dev/test
crw-r--r-- 1 root root 103, 232 Jun 2 17:07 /dev/test

and under 2.4.26 that's the same.
