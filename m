Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265287AbUGSQNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbUGSQNP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 12:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265291AbUGSQNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 12:13:15 -0400
Received: from msgdirector1.onetel.net.uk ([212.67.96.148]:27727 "EHLO
	msgdirector1.onetel.net.uk") by vger.kernel.org with ESMTP
	id S265287AbUGSQNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 12:13:13 -0400
From: Chris Lingard <chris@ukpost.com>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: PATCH Trivial fix for xconfig
Date: Mon, 19 Jul 2004 17:13:03 +0100
User-Agent: KMail/1.6.2
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200407191451.55828.chris@ukpost.com> <Pine.LNX.4.58.0407191607060.20634@scrub.home>
In-Reply-To: <Pine.LNX.4.58.0407191607060.20634@scrub.home>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407191713.03670.chris@ukpost.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 July 2004 15:09, Roman Zippel wrote:
> Hi,
>
> On Mon, 19 Jul 2004, Chris Lingard wrote:
> > When qt is installed in /usr, then there is no need to set and
> > export QTDIR; but make xconfig expects this.
>
> What distribution are you using? This would mean all qt header files are
> directly in /usr/include.

Thank you for your prompt reply.

RedHat or Linux from Scratch.  Used to install qt in /opt/qt-version
but now put qt, KDE, kitchen sink in /usr.  So all the headers do
go in /usr/include :-)

> You just broke xconfig for Debian and RH systems.

My RedHat system has QTDIR=/usr/lib/qt-3.1 in the environment,
(this was set up by the distro, and is not a hack by me).

Sorry I do not know about Debian.

My Linux from Scratch system never has QTDIR set because everything
is in /usr.

Chris Lingard


