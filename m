Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbVLNLDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbVLNLDa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 06:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbVLNLD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 06:03:29 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:45804 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932276AbVLNLD2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 06:03:28 -0500
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
       Christopher Friesen <cfriesen@nortel.com>, torvalds@osdl.org,
       akpm@osdl.org, hch@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
In-Reply-To: <1134556187.2894.7.camel@laptopd505.fenrus.org>
References: <439EDC3D.5040808@nortel.com>
	 <1134479118.11732.14.camel@localhost.localdomain>
	 <dhowells1134431145@warthog.cambridge.redhat.com>
	 <3874.1134480759@warthog.cambridge.redhat.com>
	 <15167.1134488373@warthog.cambridge.redhat.com>
	 <1134490205.11732.97.camel@localhost.localdomain>
	 <1134556187.2894.7.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 14 Dec 2005 11:03:07 +0000
Message-Id: <1134558188.25663.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-12-14 at 11:29 +0100, Arjan van de Ven wrote:
> > >      But this means that the current usages all have to be carefully audited,
> > >      and sometimes that unobvious.
> > 
> > Only if you insist on replacing them immediately. If you submit a
> > *small* patch which just adds the new mutexes then a series of small
> > patches can gradually convert code where mutexes are better. 
> 
> this unfortunately is not very realistic in practice... 

Strange because it is how most such work has been done in the past, from
the big kernel lock to the scsi core rewrite. You also forgot to attach
a reason you think it isnt realistic ?

Alan
