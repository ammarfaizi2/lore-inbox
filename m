Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292891AbSCEVTv>; Tue, 5 Mar 2002 16:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293725AbSCEVTm>; Tue, 5 Mar 2002 16:19:42 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:22798 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S292891AbSCEVTg>; Tue, 5 Mar 2002 16:19:36 -0500
Date: Tue, 5 Mar 2002 22:19:33 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.6-pre2 IDE cleanup 16
Message-ID: <20020305221933.A405@ucw.cz>
In-Reply-To: <E16i9mc-00043p-00@wagner.rustcorp.com.au> <3C84A34E.6060708@evision-ventures.com> <3C84AE16.A7F1ECCA@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C84AE16.A7F1ECCA@redhat.com>; from arjanv@redhat.com on Tue, Mar 05, 2002 at 11:37:58AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 11:37:58AM +0000, Arjan van de Ven wrote:
> Martin Dalecki wrote:
> 
> > - Disable configuration of the task file stuff. It is going to go away
> >    and will be replaced by a truly abstract interface based on
> >    functionality and *not* direct mess-up of hardware.
> 
> Can we also expect a patch to remove the scb's from the scsi midlayer
> from you ?
> I mean, if a standard specifies a nice *common* command packet format
> I'd expect the midlayer
> to create such packets. Taskfile is exactly that... why removing it ?

Note that taskfiles are not being removed from IDE. Just direct (and
parsed and filtered) interface to userspace. Does the scsi midlayer
export the SCBs directly to userspace?

-- 
Vojtech Pavlik
SuSE Labs
