Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279939AbRKFSiI>; Tue, 6 Nov 2001 13:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279925AbRKFSh7>; Tue, 6 Nov 2001 13:37:59 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39691 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279920AbRKFShh>; Tue, 6 Nov 2001 13:37:37 -0500
Subject: Re: __FD_SETSIZE question
To: roy@karlsbakk.net (Roy Sigurd Karlsbakk)
Date: Tue, 6 Nov 2001 18:44:46 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0111061921580.24965-100000@mustard.heime.net> from "Roy Sigurd Karlsbakk" at Nov 06, 2001 07:25:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E161BDK-0001N7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I heard the __FD_SETSIZE setting limits the number of open files to a
> process... Is this the fact? What happens if I double it?

It did long ago. Nowdays its limited by proc tunable variables - you do
however want to use poll() not select()
