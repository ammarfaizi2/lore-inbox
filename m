Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313744AbSDHW4S>; Mon, 8 Apr 2002 18:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313748AbSDHW4R>; Mon, 8 Apr 2002 18:56:17 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:38524 "EHLO
	hotmale.boyland.org") by vger.kernel.org with ESMTP
	id <S313744AbSDHW4Q>; Mon, 8 Apr 2002 18:56:16 -0400
Message-ID: <3CB220B8.3000305@blue-labs.org>
Date: Mon, 08 Apr 2002 18:59:04 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020402
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: "Kuppuswamy, Priyadarshini" <Priyadarshini.Kuppuswamy@compaq.com>,
        linux-kernel@vger.kernel.org
Subject: Re: system call for finding the number of cpus??
In-Reply-To: <6B003D25ADBDE347B5542AFE6A55B42E01A4451A@tayexc13.americas.cpqcorp.net> <1018301108.913.167.camel@phantasy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# grep -c "^processor" /proc/cpuinfo
2

-d

Robert Love wrote:

>
>Linux does not implement such a syscall.  Note
>
>	cat /proc/cpuinfo | grep processor | wc -l
>
>works and is simple; you do not have to do it via script - execute it in
>your C program, save the one-line output, and atoi() it.
>
>	Robert Love
>


