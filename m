Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269512AbTHBPuS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 11:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269514AbTHBPuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 11:50:18 -0400
Received: from fep02-svc.mail.telepac.pt ([194.65.5.201]:50374 "EHLO
	fep02-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id S269512AbTHBPuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 11:50:14 -0400
Date: Sat, 2 Aug 2003 13:19:21 +0100
From: Nuno Monteiro <nuno@itsari.org>
To: Pasi Savilaakso <pasi.savilaakso@pp.inet.fi>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: audio problem with 2.4.22-pre10 and 2.4.22-pre10-ac1
Message-ID: <20030802121921.GA2023@hobbes.itsari.int>
References: <200308021031.57014.pasi.savilaakso@pp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200308021031.57014.pasi.savilaakso@pp.inet.fi>; from pasi.savilaakso@pp.inet.fi on Sat, Aug 02, 2003 at 08:31:56 +0100
X-Mailer: Balsa 2.0.13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003.08.02 08:31, Pasi Savilaakso wrote:
> I have one asus a7v8x-x, which I just installed. Everything else is  
> fine
> but
> no audio. when I got this on first time after compiling kernel and  
> tried
> many
> different configs but no success at all. current audio config is at the
> end of
> mail.
>

<snip snip>


Hi Pasi,


I have a similar board lying around and I had some trouble getting sound  
to work with OSS/2.4 drivers also. As I remember. the trick was to  
connect the speakers to the microphone port (the pink one, on the far  
left), instead of the regular speaker-out. With ALSA, both on 2.4 or  
2.5/6, the sound output is on the speaker-out port, as it should. One  
small quirk though, as the sound volume is controled by the "Surround"  
mixer setting, rather than "Master" -- this has the most annoying effect  
of making the sound-volume task bar applets useless. Eventually I just  
gave up on the on-board sound and plugged in a pci soundblaster.

Hope this can help you.


Regards,



		Nuno
