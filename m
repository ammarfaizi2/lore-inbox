Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262523AbSKDShl>; Mon, 4 Nov 2002 13:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262528AbSKDShl>; Mon, 4 Nov 2002 13:37:41 -0500
Received: from [198.149.18.6] ([198.149.18.6]:15744 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S262523AbSKDShk>;
	Mon, 4 Nov 2002 13:37:40 -0500
Date: Mon, 4 Nov 2002 12:44:06 -0600
From: Nathan Straz <nstraz@sgi.com>
To: David Rees <dbr@greenhydrant.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: Spontaneous Call Trace?
Message-ID: <20021104184406.GC2030@sgi.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
References: <20021104101501.A812@greenhydrant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021104101501.A812@greenhydrant.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 10:15:01AM -0800, David Rees wrote:
> I just encountered a dual CPU machine running 2.4.18 with the NFS_ALL and
> xfs patch which spontaneously generated two complete call traces over the
> weekend.  There was no Oops or kernel bug recorded in the syslog although
> syslog functionality remained intact.  After this point functionality on the
> system was degraded (various processes were not accepting new connections)
> and we rebooted the system.  We're planning on upgrading to 2.4.19 with the
> NFS_ALL and ext3-all patches ASAP.
> 
> I've never seen this type of behavior before in my years of using Linux, has
> anyone else?  BTW, sysrq is disabled on the machine...

Could you post the call traces?  Also, do you see any relevant messages
in your log files?  Perhaps there is a forced shutdown message.

-- 
Nate Straz                                              nstraz@sgi.com
sgi, inc                                           http://www.sgi.com/
Linux Test Project                                  http://ltp.sf.net/
