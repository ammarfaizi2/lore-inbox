Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbTLUOqJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 09:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbTLUOqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 09:46:09 -0500
Received: from intra.cyclades.com ([64.186.161.6]:12453 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261957AbTLUOqH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 09:46:07 -0500
Date: Sun, 21 Dec 2003 12:37:44 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Peter Zaitsev <peter@mysql.com>
Cc: Octave <oles@ovh.net>, linux-kernel@vger.kernel.org
Subject: Re: lot of VM problem with 2.4.23
In-Reply-To: <1071999003.2156.89.camel@abyss.local>
Message-ID: <Pine.LNX.4.58L.0312211235010.6632@logos.cnet>
References: <20031221001422.GD25043@ovh.net> <1071999003.2156.89.camel@abyss.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Dec 2003, Peter Zaitsev wrote:

> On Sun, 2003-12-21 at 03:14, Octave wrote:
> > Hi,
> > Since we use 2.4.23 we have lot of crash. I have no kernel panic.
> > All I can report is this kind of syslog's message:
> > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > VM: killing process rateup

How much swap do you have in your system?

This is happening because the system is unable to free memory (you
probably ran out of swap for some reason).

