Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbVIRAw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbVIRAw4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 20:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbVIRAw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 20:52:56 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:14475 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751257AbVIRAw4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 20:52:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VirptTXhbkthowQ2wrx+h9sTah8I15LMwjWIA1TJ8qDm+q2PVwlPSn6qaODrjM7W1G+HpMvXefwAR/ZQ3ClIZ67AVVjG2H+eXYtbKMQpXjVzpdgtu+PGasTnAK0CSD9FPa0qokGOHoB7vBYTnEoe+A5XhLjyC1WJ4VSqCF8fxpI=
Message-ID: <9a87484905091717524adfc854@mail.gmail.com>
Date: Sun, 18 Sep 2005 02:52:55 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: jesper.juhl@gmail.com
To: Bernardo Innocenti <bernie@develer.com>
Subject: Re: Assertion failed in libata-core.c:ata_qc_complete(3051)
Cc: Matheus Izvekov <izvekov@lps.ele.puc-rio.br>,
       Development discussions related to Fedora Core 
	<fedora-devel-list@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>
In-Reply-To: <432CB177.5070001@develer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <432BA524.40301@develer.com>
	 <60030.200.141.101.221.1126969752.squirrel@correio.lps.ele.puc-rio.br>
	 <432CB177.5070001@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/05, Bernardo Innocenti <bernie@develer.com> wrote:
> Matheus Izvekov wrote:
> 
> >>I have a Promise TX4 controller with 4 SATA drivers
> >>formatted with a RAID1 and a RAID5 md.  LVM on top of this.
> >
> > Can you reproduce this with a stock kernel?
> 
> I've just opened the case to install some more RAM and
> noticed that the SATA controller card wasn't completely
> fitted into the PCI slot.  Could it be just a hardware
> problem?  I don't know what that assartion is about.
> 
> Nowadays, Fedora kernels don't differ much from stock
> kernels plus the usual bugfixes.  I've now upgraded to

They still do differ though. When asked to retest with a stock kernel,
indulging the person who asks is usually a good idea if you want your
problem solved :)


> 2.6.13-1.1555-FC5 because it fixes an iptables bug.
> I'll report if I see this bug again.
> 
> 
> > Also, i think it would be
> > better if instead of sending a screenshot, get a serial cable and boot
> > with console=ttyS*
> 
> This is happening on our production server, and there are no
> other computers next to it, so I can't easily hook in a
> serial cable.
> 
netconsole may be a useful alternative for you then.
See Documentation/networking/netconsole.txt


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
