Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266753AbUH0Rqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266753AbUH0Rqg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 13:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266752AbUH0Rqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 13:46:36 -0400
Received: from gsstark.mtl.istop.com ([66.11.160.162]:10905 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S266753AbUH0RqI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 13:46:08 -0400
To: Lee Revell <rlrevell@joe-job.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Todd Poynor <tpoynor@mvista.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tim.bird@am.sony.com, dsingleton@mvista.com
Subject: Re: [PATCH] Configure IDE probe delays
References: <20040730191100.GA22201@slurryseal.ddns.mvista.com>
	<1091226922.5083.13.camel@localhost.localdomain>
	<1091232770.1677.24.camel@mindpipe>
	<200407311434.59604.vda@port.imtp.ilyichevsk.odessa.ua>
	<1091296857.1677.286.camel@mindpipe>
In-Reply-To: <1091296857.1677.286.camel@mindpipe>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 27 Aug 2004 13:45:30 -0400
Message-ID: <87wtzkmq4l.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Lee Revell <rlrevell@joe-job.com> writes:

> I wonder if 83 probes are really necessary.  Maybe this could be
> optimized a bit.

Or if the kernel could be doing something useful during that time. I don't
suppose it's possible to probe two different ide interfaces at the same time,
is it?


-- 
greg

