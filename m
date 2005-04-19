Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVDSUzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVDSUzx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 16:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVDSUzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 16:55:53 -0400
Received: from ns.schottelius.org ([213.146.113.242]:54793 "HELO
	ei.schottelius.org") by vger.kernel.org with SMTP id S261262AbVDSUzs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 16:55:48 -0400
Date: Tue, 19 Apr 2005 22:54:45 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Nico Schottelius <nico-kernel@schottelius.org>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo format - arch dependent!
Message-ID: <20050419205445.GC16594@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Lee Revell <rlrevell@joe-job.com>,
	Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
	linux-kernel@vger.kernel.org
References: <20050419121530.GB23282@schottelius.org> <20050419132417.GS17865@csclub.uwaterloo.ca> <1113938220.20178.0.camel@mindpipe> <20050419200011.GB16594@schottelius.org> <1113943332.21038.6.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113943332.21038.6.camel@mindpipe>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.11.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell [Tue, Apr 19, 2005 at 04:42:12PM -0400]:
> On Tue, 2005-04-19 at 22:00 +0200, Nico Schottelius wrote:
> > Can you tell me which ones?
> > 
> 
> Multimedia apps like JACK and mplayer that use the TSC for high res
> timing need to know the CPU speed, and /proc/cpuinfo is the fast way to
> get it.
> 
> Why don't you create sysfs entries instead?  It would be better to have
> all the cpuinfo contents as one value per file anyway (faster
> application startup).

Well, sounds very good. It's a chance for me to learn to program
sysfs and also to create something useful.

So the right location to place that data would be
/sys/devices/system/cpu/cpuX?

Nico

-- 
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nico.schotteli.us | http://linux.schottelius.org
