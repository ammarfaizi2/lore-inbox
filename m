Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135729AbRDXXhA>; Tue, 24 Apr 2001 19:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135748AbRDXXgw>; Tue, 24 Apr 2001 19:36:52 -0400
Received: from quattro.sventech.com ([205.252.248.110]:29707 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S135729AbRDXXgo>; Tue, 24 Apr 2001 19:36:44 -0400
Date: Tue, 24 Apr 2001 19:36:42 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Michael Meissner <meissner@spectacle-pond.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3ac13
Message-ID: <20010424193642.J6823@sventech.com>
In-Reply-To: <E14rqT9-0000s4-00@the-village.bc.nu> <20010424193250.A4242@munchkin.spectacle-pond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <20010424193250.A4242@munchkin.spectacle-pond.org>; from Michael Meissner on Tue, Apr 24, 2001 at 07:32:50PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001, Michael Meissner <meissner@spectacle-pond.org> wrote:
> and it doesn't ask whether I want to build the normal USHI USB driver either as
> a module or builtin to the kernel, only whether I want to build the alternative
> USHI USB dirver (the JE driver).  Make xconfig asks whether you want to build
> both drivers.  I'm not sure whether this was a bug in previous versions or
> not.

That's probably because you selected the alternative UHCI driver to
build into the kernel. In that case, the other UHCI driver is not
available as an option anymore. If you select it as a module, then both
will be available.

JE

