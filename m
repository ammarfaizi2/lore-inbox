Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262767AbVAKOU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbVAKOU7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 09:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbVAKOU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 09:20:59 -0500
Received: from mail.tmr.com ([216.238.38.203]:15365 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262767AbVAKOUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 09:20:53 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Bad disks or bug ?
Date: Tue, 11 Jan 2005 09:23:31 -0500
Organization: TMR Associates, Inc
Message-ID: <41E3E163.9030804@tmr.com>
References: <41E3D2A7.3000002@sgi.com><41E3D2A7.3000002@sgi.com> <41E3D37A.2030303@abinetworks.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1105452643 17602 192.168.12.100 (11 Jan 2005 14:10:43 GMT)
X-Complaints-To: abuse@tmr.com
Cc: Prarit Bhargava <prarit@sgi.com>, linux-kernel@vger.kernel.org
To: "Ing. Gianluca Alberici" <alberici@abinetworks.biz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
In-Reply-To: <41E3D37A.2030303@abinetworks.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ing. Gianluca Alberici wrote:
> Prarit,
> 
> I run 2.4.27 on all my machines.
> 
> Never had problems but this (if we want to say its not a disk problem)
> 
> I have seen on mailing lists many people having this very problem, 
> always on hdb, with a lot of different kernel and machines.
> 
> I have basically two kind of cabinets:
> 
> - The 'Antec style' tower
> - Racmount cases
> 
> Everything well cooled...i am sure bout that.
> 
> Always ASUS A7V, Athlon XP 2xxx+, NEVER OVERCLOCKED, of course...
> 
> Disks are mainly Maxtor, or IBM
> 
> Basically i was wondering whether to swap disks on a server just to try....
> 
> ....These are the things that rave me mad !

You might see if you can swap positions in the case first, then I guess 
you would have nothing to try but actually flipping master with slave 
(and contents as well, good fun).

Just wondering, where is your swap? Your Journal? Do you have a small 
fast drive you could use for swap and external journal? I checked all 
the machines which have a similar configuration, and I don't see any 
pattern, although all the machines with really high i/o load are using SCSI.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
