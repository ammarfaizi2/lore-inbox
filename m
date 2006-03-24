Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422859AbWCXOZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422859AbWCXOZU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 09:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422860AbWCXOZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 09:25:20 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:4258 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422859AbWCXOZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 09:25:18 -0500
Subject: Re: Connector: Filesystem Events Connector v3
From: Arjan van de Ven <arjan@infradead.org>
To: yang.y.yi@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, johnpol@2ka.mipt.ru, matthltc@us.ibm.com
In-Reply-To: <4c4443230603240614m5f495340y9dc6ccc45e1e45b4@mail.gmail.com>
References: <4423673C.7000008@gmail.com>
	 <1143183541.2882.7.camel@laptopd505.fenrus.org>
	 <20060323.230649.11516073.davem@davemloft.net>
	 <4c4443230603240614m5f495340y9dc6ccc45e1e45b4@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 15:25:11 +0100
Message-Id: <1143210312.2882.72.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-24 at 22:14 +0800, yang.y.yi@gmail.com wrote:
> On 3/24/06, David S. Miller <davem@davemloft.net> wrote:
> > From: Arjan van de Ven <arjan@infradead.org>
> > Date: Fri, 24 Mar 2006 07:59:01 +0100
> >
> > > then make the syslog part optional.. if it's not already!
> >
> > Regardless I still think the filesystem events connector is a useful
> > facility.
> >
> > Audit just has way too much crap in it, and it's so much nicer to have
> > tiny modules that are optimized for specific areas of activity over
> > something like audit that tries to do everything.
> >
> the filesystem events connector is small and has low overhead, it only
> focuses on
>  activities in the filesystem

... so much that it's not useful for antivirus at least.
And your claim that audit has big overhead.. can you substantiate that?
I mean, this code has big overhead too in principle, the biggest
bottleneck is the sending-to-userspace, and that's the same in both.


