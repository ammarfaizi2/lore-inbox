Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287403AbRL3Nlw>; Sun, 30 Dec 2001 08:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287399AbRL3Nlm>; Sun, 30 Dec 2001 08:41:42 -0500
Received: from femail48.sdc1.sfba.home.com ([24.254.60.42]:35737 "EHLO
	femail48.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S287403AbRL3Nl0>; Sun, 30 Dec 2001 08:41:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: esr@thyrsus.com
Subject: Re: [kbuild-devel] Re: State of the new config & build system
Date: Sun, 30 Dec 2001 00:39:43 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011228141211.B15338@thyrsus.com> <20011229212455.GB21928@cpe-24-221-152-185.az.sprintbbd.net> <20011229174354.B8526@thyrsus.com>
In-Reply-To: <20011229174354.B8526@thyrsus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011230134125.VUHO28486.femail48.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 December 2001 05:43 pm, Eric S. Raymond wrote:
> Tom Rini <trini@kernel.crashing.org>:
> > > unless (ISA or PCI) suppress dependent IDE
> >
> > Just a minor point, but what about non-PCI/ISA ide?
>
> The CML1 rules seem to imply that this set is empty.

There are, apparently, paralell port IDE devices.

I've never seen one, but we've got drivers for them.  See PARIDE and 
paride_devices.

Rob
