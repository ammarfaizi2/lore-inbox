Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUB0BsE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 20:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbUB0BsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 20:48:03 -0500
Received: from relais.videotron.ca ([24.201.245.36]:6031 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261727AbUB0Bpw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 20:45:52 -0500
Date: Thu, 26 Feb 2004 20:48:22 -0500
From: Enrico Demarin <enricod@videotron.ca>
Subject: Re: Ibm Serveraid Problem with 2.4.25
In-reply-to: <1077839333.4823.5.camel@localhost.localdomain>
To: Jo Christian Buvarp <jcb@svorka.no>
Cc: linux-kernel@vger.kernel.org
Message-id: <1077846502.4454.2.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7)
Content-type: text/plain; CHARSET=US-ASCII
Content-transfer-encoding: 7BIT
References: <403DB882.9000401@svorka.no>
 <1077839333.4823.5.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I just checked, same message on a IBM x235 , it uses the

Fusion MPT SCSI Host driver 2.05.11.03

driver.

Same message as you  ( except the offsets vary ) when I reboot.

- Enrico

On Thu, 2004-02-26 at 18:48, Enrico Demarin wrote:
> I have the same here using the "partially opensource" drivers for a
> Promise TX2... no message on 2.4.24.I wonder if it also means it's
> corrupting the FS ? :(
> 
> 
> - Enrico
> 
> On Thu, 2004-02-26 at 04:12, Jo Christian Buvarp wrote:
> > Just upgraded my server with the 2.4.25 kernel and I noticed an error :/
> > The server is an IBM 345 with a Serveraid 5I controller, when doing an
> > dmesg i get this error:
> > 
> > attempt to access beyond end of device
> > 08:05: rw=0, want=528036, limit=528034
> > attempt to access beyond end of device
> > 08:09: rw=0, want=65208120, limit=65208118
> > 
> > This error only shows up in 2.4.25, when rebooting to 2.4.24 everything
> > looks fine :)
> > I tried upgrading the serveraid bios to the newest version (6.11.07),
> > but i still got the error.
> > 
> > So is this an bug in the kernel? Or do I have a problem on my server ?
> > Is it safe to run 2.4.25 with this error ? Or should i go back to 2.4.24
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

