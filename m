Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261892AbTCLSw2>; Wed, 12 Mar 2003 13:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261893AbTCLSw2>; Wed, 12 Mar 2003 13:52:28 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:35589 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S261892AbTCLSw1>; Wed, 12 Mar 2003 13:52:27 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303121905.h2CJ5449001606@81-2-122-30.bradfords.org.uk>
Subject: Re: bio too big device
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 12 Mar 2003 19:05:04 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b4nsh7$eg0$1@penguin.transmeta.com> from "Linus Torvalds" at Mar 12, 2003 05:59:03 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >I am not quite sure I understand your reasoning.
> >We have seen *zero* drives that do not understand 256 sector commands.
> >Maybe such drives exist, but so far there is zero evidence.
> 
> That is definitely not true.  We definitely _have_ had drives that
> misconstrue the 256-sector case. It's been a long time, but they
> definitely exist.
> 
> The right limit for IDE is 255 sectors, and doing 256 sectors WILL fail
> on some setups.

Couldn't we have a list of known good drives, though, and enable 256
sectors as a special case?

John.
