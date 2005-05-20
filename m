Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVETBJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVETBJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 21:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVETBJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 21:09:26 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:63893 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261246AbVETBJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 21:09:11 -0400
Subject: Re: oops with 2.6.12-rc2
From: Lee Revell <rlrevell@joe-job.com>
To: Narayan Desai <desai@mcs.anl.gov>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <871x82hfwx.fsf@topaz.mcs.anl.gov>
References: <87d5rmhgq3.fsf@topaz.mcs.anl.gov>
	 <1116549928.23977.21.camel@mindpipe>  <871x82hfwx.fsf@topaz.mcs.anl.gov>
Content-Type: text/plain
Date: Thu, 19 May 2005 21:09:06 -0400
Message-Id: <1116551346.23977.37.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-19 at 19:58 -0500, Narayan Desai wrote:
> >>>>> "Lee" == Lee Revell <rlrevell@joe-job.com> writes:
> 
>   Lee> That bug has been fixed.  Try 2.6.12-rc4.
> 
> OK. I will upgrade and re-post if the problem recurs. thanks. 

It looks like the patch somehow got dropped on the floor for the -stable
series.  I have no idea whether it's in -rc4.  You may want to inspect
the code before you waste your time.

Here are the two patches you need:

http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/usb/usbaudio.c?r1=1.119&r2=1.120
http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/usb/usx2y/usbusx2y.c?r1=1.9&r2=1.10

Lee


