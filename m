Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbTE2FBm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 01:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbTE2FBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 01:01:42 -0400
Received: from oceanic.wsisiz.edu.pl ([213.135.44.33]:30479 "EHLO
	oceanic.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S261876AbTE2FBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 01:01:41 -0400
Message-Id: <5.2.1.1.0.20030529070827.03f6c290@oceanic.wsisiz.edu.pl>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Thu, 29 May 2003 07:14:59 +0200
To: Andrew Morton <akpm@digeo.com>, Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
From: Bartlomiej Solarz-Niesluchowski 
	<B.Solarz-Niesluchowski@wsisiz.edu.pl>
Subject: Re: Slocate/backup, big load on 2.4.X
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030528160343.78980b13.akpm@digeo.com>
References: <Pine.LNX.4.53.0305281852220.2970@lt.wsisiz.edu.pl>
 <Pine.LNX.4.53.0305281852220.2970@lt.wsisiz.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:03 2003-05-29, Andrew Morton wrote:
>Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl> wrote:
> >
> > After 12 hours of reboot, when updatedb is running or backup via amanda,
> > system "get" very high load,
>
>High load isn't necesarily a problem - it just means that a lot of
>processes are waiting on disk I/O.  Because updatedb is flogging the disks.

For me it is problem because whole machine "freezes" (no reaction on 
anything) for 2-3 minutes.... - and after 2-3 minutes it has load about 
50-100 - I think that it has higher load (>100) when it "freezes" then 
after next 2-3 minutes situation repeates....


>Do a full "ps aux" listing and you'll probably see lots of processes in "D"
>state, waiting for the disk head to seek across and read whatever it is
>they are trying to read.

In top I can see that many processes are in state R (e.g. over 50)....

Strange it is that on slover machine (2*1GHz) and slover disks (7200 / 
160Mb/s) this was no "strange" effect like this....

Best Regards

--
Bartlomiej Solarz-Niesluchowski, Administrator WSISiZ
e-mail: B.Solarz-Niesluchowski@wsisiz.edu.pl
01-447 Warszawa, ul. Newelska 6, pokoj 404, pon.-pt. 8-16, tel. 836-92-53
Motto - nie psuj Win'9x one i bez tego sie psuja....
Jak sobie poscielisz tak sie wyspisz

