Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVALHv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVALHv4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 02:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVALHvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 02:51:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45246 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261275AbVALHvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 02:51:54 -0500
Date: Wed, 12 Jan 2005 08:49:06 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: "Jack O'Quin" <joq@io.com>
Cc: Chris Wright <chrisw@osdl.org>, Paul Davis <paul@linuxaudiosystems.com>,
       Lee Revell <rlrevell@joe-job.com>, Matt Mackall <mpm@selenic.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050112074906.GB5735@devserv.devel.redhat.com>
References: <20050111214152.GA17943@devserv.devel.redhat.com> <200501112251.j0BMp9iZ006964@localhost.localdomain> <20050111150556.S10567@build.pdx.osdl.net> <87y8ezzake.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y8ezzake.fsf@sulphur.joq.us>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 07:43:29PM -0600, Jack O'Quin wrote:
> > This is straying from the core issue...  But, Arjan's saying that an RT
> > (non-root) task could trash the filesystem if it deadlocks the machine
> > (because those important fs and IO threads don't run).
> 
> Lexicographic ambiguity: Lee and Paul are using "trash" for things
> like installing a hidden suid root shell or co-opting sendmail into an
> open spam relay.  Arjan just means crashing the system which forces
> reboot to run fsck.

I actually meant data corruption.
