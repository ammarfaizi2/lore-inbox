Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262573AbTCSW7F>; Wed, 19 Mar 2003 17:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262893AbTCSW7F>; Wed, 19 Mar 2003 17:59:05 -0500
Received: from freeside.toyota.com ([63.87.74.7]:39873 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S262573AbTCSW7F>; Wed, 19 Mar 2003 17:59:05 -0500
Message-ID: <3E78F8C5.9060403@tmsusa.com>
Date: Wed, 19 Mar 2003 15:09:57 -0800
From: jjs <jjs@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: elenstev@mesatop.com
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.65-mm2
References: <20030319012115.466970fd.akpm@digeo.com>	 <1048103489.1962.87.camel@spc9.esa.lanl.gov>	 <20030319121055.685b9b8c.akpm@digeo.com>	 <1048107434.1743.12.camel@spc1.esa.lanl.gov>	 <1048111359.1807.13.camel@spc1.esa.lanl.gov>  <3E78EC63.9050308@tmsusa.com> <1048114307.1511.12.camel@spc1.esa.lanl.gov>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven P. Cole wrote

>[root@spc1 steven]# cat /proc/sys/sched/max_timeslice
>200
>[root@spc1 steven]# echo 50 >/proc/sys/sched/max_timeslice
>[root@spc1 steven]# cat /proc/sys/sched/max_timeslice
>50
>
>Ouch. I inserted the above text saved as a file, and had to wait
>over a minute after hitting the OK button.  I aborted dbench which was
>running 24 clients on ext3 just to finish this.
>
hmm, I'd always made this sort of change
under somewhat quiescent conditions  -

Interesting results though - it helped on my
system in terms of desktop smoothness, i.e.
visible stuttering of xterm motion when being
dragged around the desktop during dbench -

Joe

