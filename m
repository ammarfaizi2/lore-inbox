Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbVHLC77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbVHLC77 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 22:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbVHLC77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 22:59:59 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:17013 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751142AbVHLC77 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 22:59:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Bedh2Jy7eQooMENAVpmoDD+SVqjrL2zXQzLfMgi92fO9C9kang7t7DDbeGJKzzZrz+Ue98IAnDyyYCz6jIjtjVqHBy681Rr4MBsXdnYGRnDF1EiHBnZoDj4It7dLr8zuYtLCoQwl2iO6IQB4E0SBFXHXqBLaDV3+ZXeceQTv6KM=
Message-ID: <195c7a900508111959710c3ca3@mail.gmail.com>
Date: Fri, 12 Aug 2005 12:59:58 +1000
From: roucaries bastien <roucaries.bastien@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Wireless support
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Jochen Friedrich <jochen@scram.de>,
       Adrian Bunk <bunk@stusta.de>, abonilla@linuxwireless.org,
       Andreas Steinmetz <ast@domdv.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1123814434.26878.21.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <005501c59c4a$f6210800$a20cc60a@amer.sykes.com>
	 <1123528018.15269.44.camel@mindpipe> <20050808232957.GR4006@stusta.de>
	 <42F872E3.3050106@scram.de>
	 <AC074A82-2B17-485A-9BFE-090CB4EE6E44@mac.com>
	 <1123814434.26878.21.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Tue, 2005-08-09 at 09:52 -0400, Kyle Moffett wrote:
> > they are much less likely to participate in any kind of reverse
> > engineering effort, even if it's just testing a new driver.
> 
> I think anyone launching a reverse engineering effort should announce
> the project to LKML!  When I set out to add some multichannel
> functionality to the emu10k1 ALSA drivers based on the kX project
> Windows drivers, I announced the project to alsa-devel and alsa-user,
> and got a number of volunteers who were most helpful in testing these
> new features, and greatly sped up the effort.  As a result we were able
> to fix almost all the major bugs before I even submitted the patch.  Now
> these new features are merged as of ALSA 1.0.9.

Problem:
o They are translating the drivers (about 66% is done, dma and pio are
close to be done) but in order to close claim for broadcom they don't
create divers. This guys will release documentation. See chinese wall
method on wikipedia.
o They post on this list 1 year and a half ago no answer.


> There is a very large group of people who can't write code but have the
> hardware and are dying to get more out of it, or just to get it to work,
> and would gladly help any Linux driver reverse engineering project, if
> they just knew about it.

o They need more programmer for reverse engeenering effort and
different programmer for writing the drivers from the documentation.
Actually 10% take about 3 months. For the courageous people, they
don't reverse directelly from asm but from C. In fact as mips asm is
pretty simple they can translate asm to C.  Nethertheless, it s
spagetty code and variable are referenced by pointer.
Reverse engeenering is therefore:
     - transform goto in for loop or while loop
     - transform *(phy+1054) in : int error or something like this.

o Testing perhaps in the end of year

Moreover this drivers will support all kind of broadcom card as the
drivers look like to be common

> Lee
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
bastien
