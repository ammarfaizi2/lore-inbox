Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWGaIaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWGaIaV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 04:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWGaIaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 04:30:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:64983 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751290AbWGaIaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 04:30:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N3eDwPpyDQEuffUE8cRxfxLTDCyG+Ggi/vS8kfnjReF5EC+47Ar4+So6glioVpCtfdANf98/LouCdhV0N9nGseZDHrhcIXnvp/WM4b3glN4OC6nDSk70esz1SFOuVnjRul7PEj050f8bklVc4RBrcZ79GcpFKA29zKnwyDklQmM=
Message-ID: <9a8748490607310130h312c9b84jec08d9f2f9b629fd@mail.gmail.com>
Date: Mon, 31 Jul 2006 10:30:18 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "bert hubert" <bert.hubert@netherlabs.nl>, "Andrew Morton" <akpm@osdl.org>,
       "Greg KH" <greg@kroah.com>,
       ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       laurent.riffard@free.fr, andrew.j.wade@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Kubuntu's udev broken with 2.6.18-rc2-mm1
In-Reply-To: <20060731075428.GA24584@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060727015639.9c89db57.akpm@osdl.org>
	 <20060731000359.GB23220@kroah.com>
	 <200607302227.07528.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
	 <20060731033757.GA13737@kroah.com>
	 <20060730212227.175c844c.akpm@osdl.org>
	 <20060731043542.GA9919@kroah.com>
	 <20060730215025.44292f9c.akpm@osdl.org>
	 <20060731051547.GB29058@kroah.com>
	 <20060730230033.cc4fc190.akpm@osdl.org>
	 <20060731075428.GA24584@outpost.ds9a.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/06, bert hubert <bert.hubert@netherlabs.nl> wrote:
> On Sun, Jul 30, 2006 at 11:00:33PM -0700, Andrew Morton wrote:
> > The impact is lower in this case because we've already trained our
> > long-suffering users to expect udev to regularly break.
>
> It has broken, even in 2.6.18-rc3, see http://lkml.org/lkml/2006/7/30/163
> '2.6.18-rc3 does not like an old udev (071)' and beyond.
>
> It now requires udev 079, in disaccordance with the Documentation/Changes
> file.
>
> This breaks Ubuntu LTS, which for some reason chose to ship udev 071.
>
It'll probably also cause trouble for the upcomming release of Slackware.
Slackware 11 is just around the corner and slackware-current currently
has udev 071. The kernel is 2.4.32 or 2.6.17.7 (user choice), but I'll
bet many people will want to install newer kernels.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
