Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWFXVI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWFXVI5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 17:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbWFXVI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 17:08:56 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48515 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964849AbWFXVIz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 17:08:55 -0400
Subject: Re: PATCH: Change in-kernel afs client filesystem name to 'kafs'
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Troy Benjegerdes <hozer@hozed.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060624182737.GQ5040@narn.hozed.org>
References: <20060624004154.GL5040@narn.hozed.org>
	 <1151151360.3181.34.camel@laptopd505.fenrus.org>
	 <20060624180136.GO5040@narn.hozed.org>
	 <20060624180953.GA4145@infradead.org>
	 <20060624182737.GQ5040@narn.hozed.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 24 Jun 2006 22:23:56 +0100
Message-Id: <1151184236.8676.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-06-24 am 13:27 -0500, ysgrifennodd Troy Benjegerdes:
> Besides the syscall table modification, which is just plain stupid, is
> there any other poking around in kernel internals the openafs code does
> that shouldn't be there?

It certainly used to pull interesting tricks to hide its auth info and
had some "novel" views of the kernel locking. Given the cachefs and FUSE
work though we ought to be at the point where almost all of OpenAFS can
be done in user space and the rest via the fuse/cachefs work.



