Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUH0Rx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUH0Rx1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 13:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266769AbUH0Rx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 13:53:27 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:47814 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261239AbUH0RxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 13:53:25 -0400
Subject: Re: [PATCH] Configure IDE probe delays
From: Lee Revell <rlrevell@joe-job.com>
To: Greg Stark <gsstark@mit.edu>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Todd Poynor <tpoynor@mvista.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tim.bird@am.sony.com, dsingleton@mvista.com
In-Reply-To: <87wtzkmq4l.fsf@stark.xeocode.com>
References: <20040730191100.GA22201@slurryseal.ddns.mvista.com>
	 <1091226922.5083.13.camel@localhost.localdomain>
	 <1091232770.1677.24.camel@mindpipe>
	 <200407311434.59604.vda@port.imtp.ilyichevsk.odessa.ua>
	 <1091296857.1677.286.camel@mindpipe>  <87wtzkmq4l.fsf@stark.xeocode.com>
Content-Type: text/plain
Message-Id: <1093629202.837.37.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 27 Aug 2004 13:53:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-27 at 13:45, Greg Stark wrote:
> Lee Revell <rlrevell@joe-job.com> writes:
> 
> > I wonder if 83 probes are really necessary.  Maybe this could be
> > optimized a bit.
> 
> Or if the kernel could be doing something useful during that time. I don't
> suppose it's possible to probe two different ide interfaces at the same time,
> is it?
> 

Did the patch to move this into a #define ever get merged?  Seems like a
no brainer, as it eliminates a magic number.

Lee

