Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314595AbSDTJPW>; Sat, 20 Apr 2002 05:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314596AbSDTJPV>; Sat, 20 Apr 2002 05:15:21 -0400
Received: from f74.pav2.hotmail.com ([64.4.37.74]:57094 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S314595AbSDTJPV>;
	Sat, 20 Apr 2002 05:15:21 -0400
X-Originating-IP: [61.155.191.205]
From: "lenny lv" <lennylv@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: qiang@suda.edu.cn
Subject: idea to enhance get_pid()
Date: Sat, 20 Apr 2002 09:15:15 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F74PKipeUekcMrvgldU00000fc8@hotmail.com>
X-OriginalArrivalTime: 20 Apr 2002 09:15:15.0891 (UTC) FILETIME=[E23CC830:01C1E84B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I've got an idea to speed up linux/kernel/fork.c/get_pid(). Why not use 
bitmap to alloc/free the pids? Is it because 4KB(32K/8) memory scanning is 
slower than the current get_pid() version? Does anyone benchmark them?

Thanks,
Lenny

_________________________________________________________________
MSN Photos is the easiest way to share and print your photos: 
http://photos.msn.com/support/worldwide.aspx

