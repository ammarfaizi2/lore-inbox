Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267509AbTAHPDc>; Wed, 8 Jan 2003 10:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267515AbTAHPDc>; Wed, 8 Jan 2003 10:03:32 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:41865 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267509AbTAHPDb>; Wed, 8 Jan 2003 10:03:31 -0500
Subject: Re: long stalls
From: Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>
To: "linux-kernel@vger" <linux-kernel@vger.kernel.org>
In-Reply-To: <3E1B8439.8040209@elegant-software.com>
References: <3E1B73F3.2070604@emageon.com> 
	<3E1B8439.8040209@elegant-software.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 08 Jan 2003 16:17:39 +0100
Message-Id: <1042039060.1290.82.camel@voyager>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-08 at 02:51, Russell Leighton wrote:
> 
> I can't help, but I can echo a "me too".
> 
> We only see it when I have 2 file I/O intensive processes...they both 
> will just stop for some few seconds, system seems idle...then
> they just start again. RH7.3 SMP, Dual PIII, 4GB RAM, 3com RAID Controller .

Same thing here with a Promise SX6000 RAID controller (P4, 1GB RAM,
system is completely on RAID, 2.4.20-pre10-ac1). But, this seems not to
be related. At least in my case, it's the controller that causes the
stalls, 'cause only processes depending on file IO (including swap) get
into D state. Everything else just runs fine.

George

-- 
Juergen "George" Sawinski                  |  Phone:  +49-6221-486-308
Max-Planck Institute for Medical Research  |  Fax:    +49-6221-486-325
Dept. of Biomedical Optics                 |  Mobile: +49-171-532 5302
Jahnstr. 29                                |  
D-69120 Heidelberg                         |  
Germany                                    |  

GPG Key/Fingerprint: 9A5F7A31/86F2E5D5EDF4D9983BDD3F23986F154F9A5F7A31

