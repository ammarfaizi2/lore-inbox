Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264620AbSLQQJs>; Tue, 17 Dec 2002 11:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264625AbSLQQJs>; Tue, 17 Dec 2002 11:09:48 -0500
Received: from franka.aracnet.com ([216.99.193.44]:34206 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264620AbSLQQJs>; Tue, 17 Dec 2002 11:09:48 -0500
Message-ID: <3DFF4D69.5080001@BitWagon.com>
Date: Tue, 17 Dec 2002 08:14:33 -0800
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
[snip]
  >    pushl %ebp
  >    movl $0xfffff000, %ebp
  >    call *%ebp
  >    popl %ebp

This does not work for mmap64 [syscall 192], which passes a parameter in %ebp.

-- 
John Reiser, jreiser@BitWagon.com

