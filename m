Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTESWTc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 18:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263302AbTESWTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 18:19:32 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11268 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263298AbTESWTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 18:19:30 -0400
Message-ID: <3EC95B58.7080807@zytor.com>
Date: Mon, 19 May 2003 15:31:52 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, sv
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Recent changes to sysctl.h breaks glibc
References: <20030519165623.GA983@mars.ravnborg.org>	<Pine.LNX.4.44.0305191039320.16596-100000@home.transmeta.com>	<babhik$sbd$1@cesium.transmeta.com> <m1d6ie37i8.fsf@frodo.biederman.org>
In-Reply-To: <m1d6ie37i8.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> 
> ABI changes or ABI additions?
> 
> If the ABI is not fixed that is a bug.  Admittedly some interfaces
> in the development kernel are still under development and so have not
> stabilized on an ABI but that is a different issue.
> 

ABI fixes and ABI additions, as well as outright ABI changes (yes they
suck, but they happen.)
> 
>>ABI headers is the only realistic solution.  We
>>can't realistically get real ABI headers for 2.5, so please don't just
>>break things randomly until then.
> 
> As the ABI remains fixed I remain unconvinced.  Multiple implementations
> against the same ABI should be possible.  The real question which is the
> more scalable way to do the code.

The ABI doesn't remain fixed.  Like everything else it evolves.

> What I find truly puzzling is that after years glibc still needs
> kernel headers at all.

What I find truly puzzling is that obviously intelligent people like
yourself still seem to think that ABIs remain fixed.

	-hpa


