Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266897AbUFYXur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266897AbUFYXur (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 19:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266896AbUFYXuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 19:50:46 -0400
Received: from europa.pnl.gov ([130.20.248.195]:48073 "EHLO europa.pnl.gov")
	by vger.kernel.org with ESMTP id S266898AbUFYXug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 19:50:36 -0400
Date: Fri, 25 Jun 2004 16:50:21 -0700
From: Kevin Fox <Kevin.Fox@pnl.gov>
Subject: Re: Elastic Quota File System (EQFS)
In-reply-to: <40DC8981.7090703@dynextechnologies.com>
To: "Fao, Sean" <Sean.Fao@dynextechnologies.com>
Cc: Amit Gud <gud@eth.net>, Alan <alan@clueserver.org>,
       Pavel Machek <pavel@ucw.cz>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       linux-kernel@vger.kernel.org
Message-id: <1088207421.4945.23.camel@nightmare.emsl.pnl.gov>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2)
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <004e01c45abd$35f8c0b0$b18309ca@home>
 <200406251444.i5PEiYpq008174@eeyore.valparaiso.cl>
 <20040625162537.GA6201@elf.ucw.cz>
 <1088181893.6558.12.camel@zontar.fnordora.org> <40DC625F.3010403@eth.net>
 <40DC8981.7090703@dynextechnologies.com>
X-OriginalArrivalTime: 25 Jun 2004 23:50:31.0265 (UTC)
 FILETIME=[3311AD10:01C45B0F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not to argue whether its a good idea but, one use for this would be
undeleting. rm becomes a set EQFS bit. You keep all your old files that
way until space is really needed and then they get reclaimed. You might
not want that to count against your quota.

On Fri, 2004-06-25 at 13:22, Fao, Sean wrote:
> Amit Gud wrote:
> 
> > It cannot be denied that there _are_ applications for such a system 
> > that we already discussed and theres a class of users who will find 
> > the system useful.
> 
> 
> I personally see no use whatsoever.  Why not just allocate 100% of the 
> file system to everybody and ignore quota's, entirely?  Each user will 
> use whatever he/she requires and when space starts to run out, users 
> will manually clean up what they don't need.
> 
> I am totally against the automatic deletion of files and believe that 
> all users will _eventually_ walk in on a Monday morning to find out that 
> the OS took it upon itself to delete a file that was flagged as elastic, 
> that shouldn't have been.  I also tend to believe that the exact 
> time/date that the file was removed could conceivably occur six months 
> prior to that Monday morning, without the users knowledge.  Now the 
> burden will again be placed on to system administrators.  This time, to 
> locate and recover the lost file(s) by sorting through months of 
> archives.  Personally, I prefer setting quota's on an individual bases, 
> to finding a needle in a haystack
> 
> In my mind, you either have a quota or you don't; there's no in between.
> 
> Sean
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
