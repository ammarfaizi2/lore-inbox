Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279407AbRKAR3y>; Thu, 1 Nov 2001 12:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279412AbRKAR3p>; Thu, 1 Nov 2001 12:29:45 -0500
Received: from t2.redhat.com ([199.183.24.243]:9465 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S279407AbRKAR3b>; Thu, 1 Nov 2001 12:29:31 -0500
Message-ID: <3BE18677.556C9CDE@redhat.com>
Date: Thu, 01 Nov 2001 17:29:27 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-4smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: Stress testing 2.4.14-pre6
In-Reply-To: <Pine.LNX.4.33.0111010903280.11617-100000@penguin.transmeta.com> <3BE18402.9F958EDC@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Linus Torvalds wrote:
> > Anyway, I seriously doubt this explains any real-world bad behaviour: the
> > window for the interrupt hitting a half-way updated list is something like
> > two instructions long out of the whole memory freeing path. AND most
> > interrupts don't actually do any allocation.
> 
> Network Rx interrupts do....  definitely not as frequent as IDE
> interrupts, but not infrequent.

Cerberus doesn't use networking in the tested setup iirc
