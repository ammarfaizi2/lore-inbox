Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283626AbSAATeY>; Tue, 1 Jan 2002 14:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283603AbSAATeO>; Tue, 1 Jan 2002 14:34:14 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:54541 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S283265AbSAATeD>; Tue, 1 Jan 2002 14:34:03 -0500
Date: Tue, 1 Jan 2002 11:37:32 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rob Landley <landley@trommello.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: New Scheduler and Digital Signal Processors?
In-Reply-To: <E16LM7L-0008Cl-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0201011128360.1456-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jan 2002, Alan Cox wrote:

> >From a scheduling point of view I would expect such a dsp to run a seperate
> OS of its own, perhaps the rtlinux core without Linux

I agree, i better see this DSPs running their own 'OS' inside their own
'domain' with the main OS talking with them in a more high level interface
more then in terms of binary to run. More, many of these DSPs are usually
handling not-shareable devices so talking about multitasking would have a
very little sense.



- Davide


