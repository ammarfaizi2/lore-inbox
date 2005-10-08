Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbVJHOzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbVJHOzp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 10:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbVJHOzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 10:55:45 -0400
Received: from host62-24-231-115.dsl.vispa.com ([62.24.231.115]:49305 "EHLO
	orac.walrond.org") by vger.kernel.org with ESMTP id S932146AbVJHOzo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 10:55:44 -0400
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Anybody know about nforce4 SATA II hot swapping + linux raid?
Date: Sat, 8 Oct 2005 15:55:40 +0100
User-Agent: KMail/1.8.2
Cc: Molle Bestefich <molle.bestefich@gmail.com>, htejun@gmail.com,
       linux-raid@vger.kernel.org
References: <200510071111.46788.andrew@walrond.org> <43477836.6020107@gmail.com> <62b0912f0510080726ge2436e9ra6d7e8d17d1001ee@mail.gmail.com>
In-Reply-To: <62b0912f0510080726ge2436e9ra6d7e8d17d1001ee@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510081555.41159.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 October 2005 15:26, Molle Bestefich wrote:
>
> IDE hotswap has never worked (OOTB at least) in Linux, and based on my
> experience it never will.  Seems the IDE folks doesn't care a bit
> about it.  (No offence meant.  Just keeping it real.)

Fair enough. What about SCSI? Do any of the in-kernel scsi drivers support 
hotswap? And if so, how well does it cooperate with linux raid?

>
> Tejun Heo wrote:
> > If you're looking for stability/resilience for production machine,
> > IMHO libata isn't still quite ready.
>
> I disagree...
> I've used it for TBs of data without any problems.

Likewise. I've been using exclusively SATA with linux raid for quite a while 
now, with great success. But for the super resilient zero downtime servers I 
now need to deploy, I must be able to swap dead drives without taking the 
server down. Hence my query.

Off-list respondants have recommended 3ware hardware raid products, but 
throughput concerns on another thread here have really put me off that idea. 
So unless linux SCSI provides a useful solution, I'll stick with what seems 
the only reliable solution out there; hardware scsi raid ( = small expensive 
drives ).

The lack of hot swapping does seem to be a serious weakness in linux, at least 
for resilient server applications. It would really complete the linux raid 
picture, and make it quite compelling.

But I'm in no position to do it myself; I can only hope this thread inspires 
some capable person to plug the gap :)

Thanks to all who responded.

Andrew Walrond
