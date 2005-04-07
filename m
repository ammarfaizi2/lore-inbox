Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbVDGSqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbVDGSqq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 14:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbVDGSqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 14:46:46 -0400
Received: from smtp7.wanadoo.fr ([193.252.22.24]:43907 "EHLO smtp7.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262547AbVDGSqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 14:46:39 -0400
X-ME-UUID: 20050407184638574.8C2901000094@mwinf0703.wanadoo.fr
Date: Thu, 7 Apr 2005 20:42:41 +0200
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
       Arjan van de Ven <arjan@infradead.org>, Christoph Hellwig <hch@lst.de>,
       Ian Campbell <ijc@hellion.org.uk>, "Theodore Ts'o" <tytso@mit.edu>,
       Greg KH <greg@kroah.com>, Michael Poole <mdpoole@troilus.org>,
       debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050407184241.GA13620@pegasos>
References: <20050404205527.GB8619@thunk.org> <20050404211931.GB3421@pegasos> <1112689164.3086.100.camel@icampbell-debian> <20050405083217.GA22724@pegasos> <1112690965.3086.107.camel@icampbell-debian> <20050405091144.GA18219@lst.de> <1112693287.6275.30.camel@laptopd505.fenrus.org> <m1wtrfk8w3.fsf@ebiederm.dsl.xmission.com> <20050407112738.GB8508@pegasos> <m1mzsakdws.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <m1mzsakdws.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 05:46:27AM -0600, Eric W. Biederman wrote:
> Sven Luther <sven.luther@wanadoo.fr> writes:
> 
> > On Wed, Apr 06, 2005 at 01:22:36PM -0600, Eric W. Biederman wrote:
> > > For tg3 a transition period shouldn't be needed as firmware loading
> > > is only needed on old/buggy hardware which is not the common case.
> > > Or to support advanced features which can be disabled.
> > > 
> > > I am fairly certain in that case the firmware came from the bcm5701 
> > > broadcom driver for the tg3 which I think is gpl'd.   So the firmware
> > > may legitimately be under the GPL.
> > 
> > So, where is the source for it ? 
> 
> The GPL'd driver that broadcom distributes.  The history of tg3.c
> is that broadcom's bcm57xx driver drove the hardware correctly but
> not linux so it was rewritten from scratch. 

Ok, thanks for that clarification.

> Beyond that you need to talk to Broadcom.  But if the originator
> of the bits  distributes them gpl from a redistribution point the
> kernel is fine.  

As you may know, i have contacted Broadcom about this issue, the information
passed from the driver support contact to their linux developers, but i have
not heard from them yet.

> It sounds like you are now looking at the question of are the
> huge string of hex characters the preferred form for making
> modifications to firmware.  Personally I would be surprised
> but those hunks are small enough it could have been written
> in machine code.

Yep, i also think it is in broadcom's best interest to modify the licencing
text accordyingly, since i suppose someone could technicaly come after them
legally to obtain said source code to this firmware. Unprobable though.

> So I currently have no reason to believe that anything has been
> done improperly with that code.

Well, it all depends if you consider this firmware blob as software, which i
feel it is without doubt, or we have not the same definition of software,
i.e., the program which runs on the hardware, or not. We cannot claim this is data,
since there should be at least some kind of executable code in it,
independenlty of the fact that we claim that data is also software.

Thanks for the info, i will add it to the Wiki.

Friendly,

Sven Luther

