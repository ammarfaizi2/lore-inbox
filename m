Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279596AbRKFP23>; Tue, 6 Nov 2001 10:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279688AbRKFP2U>; Tue, 6 Nov 2001 10:28:20 -0500
Received: from t2.redhat.com ([199.183.24.243]:58357 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S279596AbRKFP2A>; Tue, 6 Nov 2001 10:28:00 -0500
Message-ID: <3BE8017E.1BFF5E2D@redhat.com>
Date: Tue, 06 Nov 2001 15:27:58 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-7smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: Mylex/Compaq RAID controller placement in config
In-Reply-To: <E1617xB-0000ln-00@the-village.bc.nu> <Pine.LNX.4.30.0111061612570.23908-100000@mustard.heime.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:
> 
> > Because they are ?
> >
> > They dont provide scsi as the native interface (nor do some of the others
> > but thats a seperate saga)
> 
> I know it might seem silly, but as to make things clearer for most
> users/admins, wouldn't it be better to just call them SCSI controllers, as
> they all indeed connect SCSI drives to the host?

They're not SCSI _controllers_. They happen to like scsi drivers, but
there's nothing 
scsi about the controller. and admins would expect all controllers from
the
"SCSI Controllers" menu to show up as /dev/sda etc, which these don't.

> ---
> MCSE, MCNE, CLS, LCA

Maybe this explains it ;)
