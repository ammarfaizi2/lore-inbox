Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263361AbTESXSD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 19:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbTESXSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 19:18:02 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57099 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263361AbTESXSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 19:18:01 -0400
Message-ID: <3EC9691A.6000506@zytor.com>
Date: Mon, 19 May 2003 16:30:34 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Recent changes to sysctl.h breaks glibc
References: <20030519165623.GA983@mars.ravnborg.org>	 <Pine.LNX.4.44.0305191039320.16596-100000@home.transmeta.com>	 <babhik$sbd$1@cesium.transmeta.com> <m1d6ie37i8.fsf@frodo.biederman.org>	 <3EC95B58.7080807@zytor.com> <1053382815.29227.29.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1053382815.29227.29.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Llu, 2003-05-19 at 23:31, H. Peter Anvin wrote:
> 
>>What I find truly puzzling is that obviously intelligent people like
>>yourself still seem to think that ABIs remain fixed.
> 
> Because with a few deep system stuff exceptions they do, although they
> certainly extend. Rogue for 0.98.5 still runs on 2.4.21 (although you
> may have fun finding libc2.2.2)

That's my point, though: the ABI *as a whole* does not remain fixed,
even though it evolves according to rules, one of which is try to
maintain backwards compatibility.

The "copy-and-modify" mantra doesn't take that into account, nevermind
the GPL issues.

	-hpa

