Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292882AbSBVOk4>; Fri, 22 Feb 2002 09:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292879AbSBVOkh>; Fri, 22 Feb 2002 09:40:37 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:36613 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S292880AbSBVOkQ>; Fri, 22 Feb 2002 09:40:16 -0500
Date: Fri, 22 Feb 2002 15:40:11 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
Message-ID: <20020222154011.B5783@suse.cz>
In-Reply-To: <Pine.LNX.4.33.0202131434350.21395-100000@home.transmeta.com> <3C723B15.2030409@evision-ventures.com> <00a201c1bb8d$90dd2740$0300a8c0@lemon> <3C764B7C.2000609@evision-ventures.com> <3C764B7C.2000609@evision-ventures.com>; <20020222150323.A5530@suse.cz> <3C7652C7.96D0B730@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C7652C7.96D0B730@redhat.com>; from arjanv@redhat.com on Fri, Feb 22, 2002 at 02:16:39PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 02:16:39PM +0000, Arjan van de Ven wrote:

> > I think it'd be even better if the chipset drivers did the probing
> > themselves, and once they find the IDE device, they can register it with
> > the IDE core. Same as all the other subsystem do this.
> 
> Please send me your scsi subsystem then ;)

I must agree that SCSI controllers aren't doing their probing in a
uniform and clean way even on PCI, but at least they do the probing
themselves and don't have the mid-layer SCSI code do it for them like
IDE.

-- 
Vojtech Pavlik
SuSE Labs
