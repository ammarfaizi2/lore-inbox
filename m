Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbUKGCGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbUKGCGF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 21:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbUKGCGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 21:06:05 -0500
Received: from serio.al.rim.or.jp ([202.247.191.123]:31418 "EHLO
	serio.al.rim.or.jp") by vger.kernel.org with ESMTP id S261512AbUKGCF4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 21:05:56 -0500
Message-ID: <418D8301.1070202@yk.rim.or.jp>
Date: Sun, 07 Nov 2004 11:05:53 +0900
From: Chiaki <ishikawa@yk.rim.or.jp>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Chiaki <ishikawa@yk.rim.or.jp>
Subject: Re: Configuration system bug? : tmpfs listing in /proc/filesystems
 when TMPFS was not configured!?
References: <418D0EFB.2040002@yk.rim.or.jp> <418D7AF4.5090500@yk.rim.or.jp>
In-Reply-To: <418D7AF4.5090500@yk.rim.or.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chiaki wrote:
> Chiaki wrote:
> 
>> (Please cc: me since I am not subscribed to linux-kernel list.)
>>
>> I think there is something fishy about kernel 2.6.9.
>>
>> I failed to enable TMPFS during configuration of
>> my linux kernel 2.6.9.
>>
>> However, somehow /proc/filesystems lists "nodev tmpfs" line !?
>>
>> Is this to be expected?
>>
> 
> Just in case, the compilation of the kernel used stale object files, or
> something,
> I recompiled the kernel after running make clean.
> 
> Still, "tmpfs" shows up in /proc/filesystems
> listing although TMPFS was not configured.
> 
> I tried to figure out where "tmpfs" was
> exported to /proc/filesystems, but could
> not.
> 
> This bug may bite more users in subtle ways
> in the future.
> 
> BTW, the kernel version is 2.6.9
> (-test-tmscsim suffix to the version string below
> is added to remind me that I was testing tmscsim SCSI driver module.)
> 
> ishikawa@duron$ uname -a
> Linux duron 2.6.9-test-tmscsim #11 Sun Nov 7 03:28:42 JST 2004 i686 
> GNU/Linux
> 
> Is there a specific sub-system module to whose maintainer
> I should submit a bug report?
> 
> 


-- 
int main(void){int j=2003;/*(c)2003 cishikawa. */
char t[] ="<CI> @abcdefghijklmnopqrstuvwxyz.,\n\"";
char *i ="g>qtCIuqivb,gCwe\np@.ietCIuqi\"tqkvv is>dnamz";
while(*i)((j+=strchr(t,*i++)-(int)t),(j%=sizeof t-1),
(putchar(t[j])));return 0;}/* under GPL */
