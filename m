Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288308AbSBMS3Y>; Wed, 13 Feb 2002 13:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288342AbSBMS3P>; Wed, 13 Feb 2002 13:29:15 -0500
Received: from ns.suse.de ([213.95.15.193]:47111 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288308AbSBMS26>;
	Wed, 13 Feb 2002 13:28:58 -0500
Date: Wed, 13 Feb 2002 19:28:51 +0100
From: Dave Jones <davej@suse.de>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: portmap problems with 2.5.4-pre5
Message-ID: <20020213192851.C925@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0202130818430.15774-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0202130818430.15774-100000@netfinity.realnet.co.sz>; from zwane@linux.realnet.co.sz on Wed, Feb 13, 2002 at 08:20:34AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2002 at 08:20:34AM +0200, Zwane Mwaikambo wrote:
 > I tried to mount an NFS filesystem and had mount stuck in the D state for 
 > quite a while (minutes), this was also in my logs.
 > 
 > Jan  1 02:06:00 mondecino kernel: portmap: server localhost not responding, timed out
 > Jan  1 02:06:00 mondecino kernel: lockd_up: makesock failed, error=-5
 > Jan  1 02:07:40 mondecino kernel: portmap: server localhost not responding, timed out
 > 
 > Eventually it did mount, but i've never had this error before on that box 
 > (i use the box daily and do that mount more than 5 times a day). I've been 
 > using 2.5 on that box since 2.5.0. I seem to be able to reproduce it, so 
 > i'll leave the box running in case anyone wants to try anything.

 Richard Henderson mentioned it yesterday in the Re: thread_info implementation
 thread. (msgid: 20020211154917.A19367@are.twiddle.net). I've also seen
 it recently (circa .4pre3), then it went away, and now I have a box thats also
 doing it repeatedly.

 afaik, no-one else has looked at it in detail yet (or seen it?)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
