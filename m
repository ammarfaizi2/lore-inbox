Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261614AbSIXImn>; Tue, 24 Sep 2002 04:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261616AbSIXImn>; Tue, 24 Sep 2002 04:42:43 -0400
Received: from pro18.it.dtu.dk ([130.225.76.218]:19332 "EHLO pro18.it.dtu.dk")
	by vger.kernel.org with ESMTP id <S261614AbSIXImn>;
	Tue, 24 Sep 2002 04:42:43 -0400
Message-ID: <3D9026B6.3080509@fugmann.dhs.org>
Date: Tue, 24 Sep 2002 10:47:50 +0200
From: Anders Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Q: Scheduler and need_resched
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I got a small question of what happens codevice when the quantum of a 
task is expired (counter == 0 -> need_resched == 1). Of cource schedule 
is invoked somehow, but from where? How is the "flow". I see from where 
do_timer is called, and that it schedules a BH, but then I'm stuck.

I have a feeling that some function is called (at least) each timer 
tick, which tests if schedules sould be called (a test on need_resched 
amongst others). I just cannot seem to find this function.

Any pointer appriciated.
Anders Fugmann





