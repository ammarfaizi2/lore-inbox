Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266242AbUFYUWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266242AbUFYUWs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 16:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUFYUWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 16:22:48 -0400
Received: from mail.dynextechnologies.com ([65.120.73.98]:34342 "EHLO
	mail.dynextechnologies.com") by vger.kernel.org with ESMTP
	id S266242AbUFYUWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 16:22:47 -0400
Message-ID: <40DC8981.7090703@dynextechnologies.com>
Date: Fri, 25 Jun 2004 16:22:25 -0400
From: "Fao, Sean" <Sean.Fao@dynextechnologies.com>
User-Agent: Mozilla Thunderbird 0.7 (Windows/20040616)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Amit Gud <gud@eth.net>
CC: Alan <alan@clueserver.org>, Pavel Machek <pavel@ucw.cz>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org
Subject: Re: Elastic Quota File System (EQFS)
References: <004e01c45abd$35f8c0b0$b18309ca@home>	 <200406251444.i5PEiYpq008174@eeyore.valparaiso.cl>	 <20040625162537.GA6201@elf.ucw.cz> <1088181893.6558.12.camel@zontar.fnordora.org> <40DC625F.3010403@eth.net>
In-Reply-To: <40DC625F.3010403@eth.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Jun 2004 20:22:46.0706 (UTC) FILETIME=[2D9CE920:01C45AF2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit Gud wrote:

> It cannot be denied that there _are_ applications for such a system 
> that we already discussed and theres a class of users who will find 
> the system useful.


I personally see no use whatsoever.  Why not just allocate 100% of the 
file system to everybody and ignore quota's, entirely?  Each user will 
use whatever he/she requires and when space starts to run out, users 
will manually clean up what they don't need.

I am totally against the automatic deletion of files and believe that 
all users will _eventually_ walk in on a Monday morning to find out that 
the OS took it upon itself to delete a file that was flagged as elastic, 
that shouldn't have been.  I also tend to believe that the exact 
time/date that the file was removed could conceivably occur six months 
prior to that Monday morning, without the users knowledge.  Now the 
burden will again be placed on to system administrators.  This time, to 
locate and recover the lost file(s) by sorting through months of 
archives.  Personally, I prefer setting quota's on an individual bases, 
to finding a needle in a haystack

In my mind, you either have a quota or you don't; there's no in between.

Sean

