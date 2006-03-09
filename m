Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751617AbWCIVcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbWCIVcO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 16:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbWCIVcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 16:32:14 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:11926 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751617AbWCIVcO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 16:32:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l2ZWKhII0QTE8dYG9uiUxiE1NlbcYBLbalzas9v48vHHYOvCaY/QJOANBGMeqT/1Kc5Qml01+fkL4jbVx3zq2SJtp8b1wt7KCq3ZQVxee7C2aft/Ftrdq8rCXbGuVKRs41m3ZPHtTx//hq8j2vHTxZyjG4THnlJf9oF4AkGtgOY=
Message-ID: <9f7850090603091332m7517eaafrd9f180ec5a358a55@mail.gmail.com>
Date: Thu, 9 Mar 2006 13:32:12 -0800
From: "marty fouts" <mf.danger@gmail.com>
To: "Dave Neuer" <mr.fred.smoothie@pobox.com>
Subject: Re: [future of drivers?] a proposal for binary drivers.
Cc: "Xavier Bestel" <xavier.bestel@free.fr>, "Phillip Susi" <psusi@cfl.rr.com>,
       Luke-Jr <luke@dashjr.org>, "Anshuman Gholap" <anshu.pg@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <161717d50603091222p34b45065xdb8507cbf8191a3d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <ec92bc30603080135j5257c992k2452f64752d38abd@mail.gmail.com>
	 <200603091509.06173.luke@dashjr.org> <441057D4.6030304@cfl.rr.com>
	 <161717d50603090933o3df190f9vb1e06b0ec37deb8e@mail.gmail.com>
	 <1141928755.7599.0.camel@bip.parateam.prv>
	 <161717d50603091222p34b45065xdb8507cbf8191a3d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But I stand by my assertion: many kernel developers on record stating
> that they don't want their work used in binary-only modules, and the
> reason that this hasn't been decided by a court yet is no sufficiently
> deep-pocketed plaintiff (independantly wealthy kernel hackers or a big
> corporation with copyright interest in the kernel) has decided to sue,
> yet.
>
> See Linus' statements here:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0312.0/0670.html
> and here: http://www.ussg.iu.edu/hypermail/linux/kernel/0312.1/0708.html
> if you think I'm just pulling this stuff out of my butt.
>

Looking at Linus' arguments, how would you say those kernel developers
feel about the following scenario:

I have access to a 3rd party file system, written not for Linux but
for some completely different OS. But my license with that vendor does
not allow me to distribute the file system.   I write the translation
layer that they describe in their documentation that allows me to drop
their file system, unchanged, into Linux. I GPL the translation layer
and make the source available appropriately. (This is similar to the
AFS point in Linus' email, but not exactly the same.) I do not, since
I don't permission to, distribute the source for the third party OS.

1) Have I met my legal obligation under the GPL? (Seems to me Linus
would say yes, but I want to understand other people's view on this.)

2) Will the developers you mention above be unhappy anyway, even if I have?
