Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030869AbWI0VVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030869AbWI0VVn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 17:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030870AbWI0VVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 17:21:43 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:57520 "EHLO
	fmmailgate02.web.de") by vger.kernel.org with ESMTP
	id S1030869AbWI0VVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 17:21:40 -0400
Message-ID: <008f01c6e27a$f9bd5460$962e8d52@aldipc>
From: "roland" <devzero@web.de>
To: "Fengguang Wu" <fengguang.wu@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <lserinol@gmail.com>, <akpm@osdl.org>
References: <0e2001c6de7a$fe756280$962e8d52@aldipc> <359067036.19509@ustc.edu.cn>
Subject: Re: I/O statistics per process
Date: Wed, 27 Sep 2006 23:22:02 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks. tried to contact redflag, but they don`t answer. maybe support is 
being on holiday.... !?

linux kernel hackers - there is really no standard way to watch i/o metrics 
(bytes read/written) at process level?

it`s extremly hard for the admin to track down, what process is hogging the 
disk - especially if there is more than one task consuming cpu.

meanwhile i found blktrace and read into the documenation. looks really cool 
and seems to be very powerful tool - but it it`s seems a little bit 
"oversized" and not the right tool for this. seems to be for 
tracing/debugging/analysis

what about http://lkml.org/lkml/2005/9/12/89  "with following patch, 
userspace processes/utilities will be able to access per process I/O 
statistics. for example, top like utilites can use this information" which 
has been posted to lkml one year ago ? any update on this ?

roland


----- Original Message ----- 
From: "Fengguang Wu" <fengguang.wu@gmail.com>
To: "roland" <devzero@web.de>
Cc: <linux-kernel@vger.kernel.org>
Sent: Sunday, September 24, 2006 5:04 AM
Subject: Re: I/O statistics per process


> On Fri, Sep 22, 2006 at 09:12:05PM +0200, roland wrote:
>> is there a modified top/ps with i/o column, or is there yet missing
>> something at the kernel level for getting that counters from ?
>
> Red Flag(http://www.redflag-linux.com/eindex.html) has developed an
> iotop based on kprobes/systemtap. You can contact them if necessary. 

