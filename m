Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135825AbRDTH6P>; Fri, 20 Apr 2001 03:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135824AbRDTH6H>; Fri, 20 Apr 2001 03:58:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:47759 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135763AbRDTH5w>;
	Fri, 20 Apr 2001 03:57:52 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15071.60410.77165.185841@pizda.ninka.net>
Date: Fri, 20 Apr 2001 00:57:46 -0700 (PDT)
To: David Howells <dhowells@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic rw_semaphores, compile warnings patch 
In-Reply-To: <24459.987753038@warthog.cambridge.redhat.com>
In-Reply-To: <15071.30776.914468.900710@pizda.ninka.net>
	<24459.987753038@warthog.cambridge.redhat.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Howells writes:
 > There's also a missing "struct rw_semaphore;" declaration in linux/rwsem.h. It
 > needs to go in the gap below "#include <linux/wait.h>". Otherwise the
 > declarations for the contention handling functions will give warnings about
 > the struct being declared in the parameter list.

Indeed, I didn't see this in my setup on sparc64 for some reason.

Later,
David S. Miller
davem@redhat.com

