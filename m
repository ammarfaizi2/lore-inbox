Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274549AbRJJDzv>; Tue, 9 Oct 2001 23:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274533AbRJJDzi>; Tue, 9 Oct 2001 23:55:38 -0400
Received: from Cambot.lecs.CS.UCLA.EDU ([131.179.144.110]:58635 "EHLO
	cambot.lecs.cs.ucla.edu") by vger.kernel.org with ESMTP
	id <S274530AbRJJDze>; Tue, 9 Oct 2001 23:55:34 -0400
Date: Tue, 9 Oct 2001 20:55:48 -0700 (PDT)
From: Jeremy Elson <jelson@circlemud.org>
To: Pavel Machek <pavel@Elf.ucw.cz>
cc: Jeremy Elson <jelson@circlemud.org>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] FUSD v1.00: Framework for User-Space Devices
In-Reply-To: <20011005205136.A1272@elf.ucw.cz>
Message-ID: <Pine.LNX.4.21.0110092049580.780-100000@cambot.lecs.cs.ucla.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Oct 2001, Pavel Machek wrote:
> Yep. And linmodem driver does signal processing, so it is big and
> ugly. And up till now, it had to be in kernel. With your patches, such
> drivers could be userspace (where they belong!). Of course, it would be 
> very good if your interface did not change...

FUSD's user-kernel interface won't change spuriously, but it sometimes
will need to change as features are added.  Some such changes are
already in the works.

The fact that FUSD provides a semi-stable binary interface for servicing
device-file callbacks isn't really FUSD's design goal as much as it is an
accidental side effect.  Making a stable binary interface for kernel
device drivers is the objective of, say, UDI (I think).  The purpose of
FUSD is just to be able to proxy the callbacks to userspace.

Best,
Jer


