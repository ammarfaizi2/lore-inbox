Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285618AbSBCC6b>; Sat, 2 Feb 2002 21:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285352AbSBCC6V>; Sat, 2 Feb 2002 21:58:21 -0500
Received: from hermes.toad.net ([162.33.130.251]:64669 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S285093AbSBCC6M>;
	Sat, 2 Feb 2002 21:58:12 -0500
Subject: Re: apm.c and multiple battery slots
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 02 Feb 2002 21:58:22 -0500
Message-Id: <1012705104.774.4.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stevie O <stevie@qrpff.net> wrote:
> I suggest we change the first line to reflect an
> overall battery status (i.e. average of all slots
> in system).

Sounds like a good idea.

> Then we could add one line for each battery slot,
> indicating <battery status> <battery flag> <battery left % >
> <remaining time in seconds>

How about putting each of these lines in a separate proc
file?  This would avoid changing the format of /proc/apm,
which would break things.

--
Thomas

