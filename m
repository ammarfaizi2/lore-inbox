Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273043AbRIIUp7>; Sun, 9 Sep 2001 16:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273042AbRIIUpu>; Sun, 9 Sep 2001 16:45:50 -0400
Received: from unused ([12.150.234.220]:55038 "EHLO one.isilinux.com")
	by vger.kernel.org with ESMTP id <S273039AbRIIUpm>;
	Sun, 9 Sep 2001 16:45:42 -0400
Message-ID: <3B9BD508.1050200@interactivesi.com>
Date: Sun, 09 Sep 2001 15:46:00 -0500
From: Timur Tabi <ttabi@interactivesi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3+) Gecko/20010815
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Which CPU do timers run on?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I create a timer (init_timer(), etc) on an SMP system, will the timer 
always run on one CPU, or can it run on any CPU?  If I disabled interrupts on 
only one CPU, will that disable the timer completely?

