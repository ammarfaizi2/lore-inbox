Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270658AbTGNNOJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 09:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270653AbTGNNOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 09:14:05 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:45501 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S270703AbTGNNNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 09:13:46 -0400
Date: Mon, 14 Jul 2003 10:26:02 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: sim710 resend #5
In-Reply-To: <200307141224.h6ECOrQj030905@hraefn.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.55L.0307141019560.18257@freak.distro.conectiva>
References: <200307141224.h6ECOrQj030905@hraefn.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


And it doenst apply:

marcelo@freak linux-2.4.22-pre5]$ patch -p1 < /tmp/sim
patching file drivers/scsi/sim710_d.h
Reversed (or previously applied) patch detected!  Assume -R? [n]
Apply anyway? [n]
Skipping patch.
9 out of 9 hunks ignored -- saving rejects to file
drivers/scsi/sim710_d.h.rej

that linux-2.4.22-pre5 tree has been generated out of local BK tree.

Now if I apply your patch against a 2.4.22-pre5 from tarballs and patches
it works fine. Weird.

I'll investigate it later.
