Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132548AbRDUJPf>; Sat, 21 Apr 2001 05:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132547AbRDUJPa>; Sat, 21 Apr 2001 05:15:30 -0400
Received: from mail.cis.nctu.edu.tw ([140.113.23.5]:1545 "EHLO
	mail.cis.nctu.edu.tw") by vger.kernel.org with ESMTP
	id <S132553AbRDUJO6>; Sat, 21 Apr 2001 05:14:58 -0400
Message-ID: <005201c0ca44$755203f0$ae58718c@cis.nctu.edu.tw>
Reply-To: "gis88530" <gis88530@cis.nctu.edu.tw>
From: "gis88530" <gis88530@cis.nctu.edu.tw>
To: <linux-kernel@vger.kernel.org>
Subject: I can't find out the answer
Date: Sat, 21 Apr 2001 17:21:32 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I want to calculate the total memory usage of kernel.
I wonder that we just need to add these(*1) in slabinfo or 
we need to add each line(*1 and *2) in slabinfo. Thanks.
AND
I know the size of size-512 is 512 bytes, but I want to know
the size of tcp_tw_bucket, tcp_open_request, etc.
How can I find out this answer? Thanks a lot.

*1
size-131072            0      0
size-65536             0      0
size-32768             0      0
size-16384            11     11
size-8192              1      1
size-4096              8     12
size-2048            153    284
size-1024             20    688
size-512              54     64
size-256              51     70
size-128             396    600
size-64              942   1050
size-32             3964   7245

*2
kmem_cache            30     42
pio_request            0      0
tcp_tw_bucket          5    126
tcp_bind_bucket       45    127
tcp_open_request       0     63
skbuff_head_cache     57    693
sock                  94    132
dquot                  0      0
filp                1677   1680
signal_queue           0     29
kiobuf                 0      0
buffer_head        48636  60396
mm_struct             61     93
vm_area_struct      2081   2835
dentry_cache       18304  19933
files_cache           68     90
uid_cache             10    127
slab_cache           183    189


