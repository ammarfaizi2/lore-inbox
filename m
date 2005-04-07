Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262494AbVDGPpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbVDGPpn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 11:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbVDGPpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 11:45:43 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61883 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262494AbVDGPpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 11:45:35 -0400
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Arjan van de Ven <arjan@infradead.org>, Christoph Hellwig <hch@lst.de>,
       Ian Campbell <ijc@hellion.org.uk>, "Theodore Ts'o" <tytso@mit.edu>,
       Greg KH <greg@kroah.com>, Michael Poole <mdpoole@troilus.org>,
       debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
References: <20050404191745.GB12141@kroah.com> <20050404192945.GB1829@pegasos>
	<20050404205527.GB8619@thunk.org> <20050404211931.GB3421@pegasos>
	<1112689164.3086.100.camel@icampbell-debian>
	<20050405083217.GA22724@pegasos>
	<1112690965.3086.107.camel@icampbell-debian>
	<20050405091144.GA18219@lst.de>
	<1112693287.6275.30.camel@laptopd505.fenrus.org>
	<m1wtrfk8w3.fsf@ebiederm.dsl.xmission.com>
	<20050407112738.GB8508@pegasos>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Apr 2005 05:46:27 -0600
In-Reply-To: <20050407112738.GB8508@pegasos>
Message-ID: <m1mzsakdws.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Luther <sven.luther@wanadoo.fr> writes:

> On Wed, Apr 06, 2005 at 01:22:36PM -0600, Eric W. Biederman wrote:
> > For tg3 a transition period shouldn't be needed as firmware loading
> > is only needed on old/buggy hardware which is not the common case.
> > Or to support advanced features which can be disabled.
> > 
> > I am fairly certain in that case the firmware came from the bcm5701 
> > broadcom driver for the tg3 which I think is gpl'd.   So the firmware
> > may legitimately be under the GPL.
> 
> So, where is the source for it ? 

The GPL'd driver that broadcom distributes.  The history of tg3.c
is that broadcom's bcm57xx driver drove the hardware correctly but
not linux so it was rewritten from scratch. 

Beyond that you need to talk to Broadcom.  But if the originator
of the bits  distributes them gpl from a redistribution point the
kernel is fine.  

It sounds like you are now looking at the question of are the
huge string of hex characters the preferred form for making
modifications to firmware.  Personally I would be surprised
but those hunks are small enough it could have been written
in machine code.

So I currently have no reason to believe that anything has been
done improperly with that code.

Eric
