Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313440AbSDGTcD>; Sun, 7 Apr 2002 15:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313441AbSDGTcC>; Sun, 7 Apr 2002 15:32:02 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14088 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313440AbSDGTcC>; Sun, 7 Apr 2002 15:32:02 -0400
Subject: Re: Two fixes for 2.4.19-pre5-ac3
To: movement@marcelothewonderpenguin.com (John Levon)
Date: Sun, 7 Apr 2002 20:49:17 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        shirsch@adelphia.net (Steven N. Hirsch), linux-kernel@vger.kernel.org
In-Reply-To: <20020407173343.GA18940@compsoc.man.ac.uk> from "John Levon" at Apr 07, 2002 06:33:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16uIf7-0006Zw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But what about the recent discussion on the removal of sys_call_table ?
> 
> (I believe it was along the lines of "it's ugly, prevent it ...", "ah,
> but it has real uses, so why can't it stay as deprecated/unadvised ?"
> "*no response*").
> 
> I'm a bit disappointed this has just gone in without any real discussion
> on the usefulness of this for certain circumstances :(

Removing it in the -ac tree is a good way to stimulate discussion and
fixing the code that relies on it (except for the 99% of code relying on it
which is cracker authored trojans)
