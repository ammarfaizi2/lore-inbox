Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267342AbTAQA35>; Thu, 16 Jan 2003 19:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267343AbTAQA35>; Thu, 16 Jan 2003 19:29:57 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:11492 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S267342AbTAQA34>; Thu, 16 Jan 2003 19:29:56 -0500
Date: Thu, 16 Jan 2003 16:38:45 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Joel Becker <Joel.Becker@oracle.com>, lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Wim Coekaerts <Wim.Coekaerts@oracle.com>
Subject: Re: [PATCH] hangcheck-timer
Message-ID: <20030117003845.GX20972@ca-server1.us.oracle.com>
References: <20030116231727.GV20972@ca-server1.us.oracle.com> <Pine.LNX.4.44.0301161841570.24250-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301161841570.24250-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.4i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2003 at 06:43:47PM -0500, Zwane Mwaikambo wrote:
> NMI watchdog? Doesn't look like this can catch cases where you have 
> interrupts disabled and spinning on a lock, if you manage to run this code 
> then the box isn't really locked up. In which case the software watchdog 
> should be as good as this.

	Please read again.  This isn't about catching a complete lockup.
This is about catching a pause and resume that jiffies does not notice.

Joel

-- 

Life's Little Instruction Book #15

	"Own a great stereo system."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
