Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281770AbRKWXsf>; Fri, 23 Nov 2001 18:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282287AbRKWXsZ>; Fri, 23 Nov 2001 18:48:25 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:51726 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S281770AbRKWXsQ>;
	Fri, 23 Nov 2001 18:48:16 -0500
Date: Sat, 24 Nov 2001 10:47:16 +1100
From: Anton Blanchard <anton@samba.org>
To: Phil Howard <phil-linux-kernel@ipal.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.15: undefined reference to `show_trace_task'
Message-ID: <20011124104716.C1178@krispykreme>
In-Reply-To: <20011123173602.A14759@vega.ipal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011123173602.A14759@vega.ipal.net>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Can the call to show_trace_task() in kernel/sched.c be safely commented
> out for now?

Yes I tried to get Linus to add just one more #ifdef around
show_trace_task and I guess it was one too many :) 

Its only a debugging aid, for the moment just create an empty
show_trace_task() 

Anton
