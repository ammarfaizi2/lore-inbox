Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262386AbVFIOXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbVFIOXB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 10:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbVFIOXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 10:23:01 -0400
Received: from web25804.mail.ukl.yahoo.com ([217.12.10.189]:17547 "HELO
	web25804.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262386AbVFIOWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 10:22:51 -0400
Message-ID: <20050609142250.80926.qmail@web25804.mail.ukl.yahoo.com>
Date: Thu, 9 Jun 2005 16:22:49 +0200 (CEST)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: [TTY] exclusive mode question
To: Frederik Deweerdt <dev.deweerdt@laposte.net>
Cc: Frederik Deweerdt <dev.deweerdt@laposte.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20050609121638.GD507@gilgamesh.home.res>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Frederik Deweerdt <dev.deweerdt@laposte.net> a écrit :

> Le 09/06/05 13:41 +0200, moreau francis écrivit:
> > 
> > oh ok...sorry I misunderstood TIOEXCL meaning ;)
> > Do you know how I could implement such exclusive mode (the one I described)
> ?
> > 
> This is handled through lock files, google for LCK..ttyS0
>

This lock mechanism is a convention but nothing prevent a user application to
issue a "echo foo > /dev/ttyS0" command while "LCK..ttyS0" file exists...

            Francis


	
	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com
