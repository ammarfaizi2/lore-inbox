Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315282AbSEVWXy>; Wed, 22 May 2002 18:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315285AbSEVWXx>; Wed, 22 May 2002 18:23:53 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14089 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315282AbSEVWXw>; Wed, 22 May 2002 18:23:52 -0400
Subject: Re: AUDIT: copy_from_user is a deathtrap.
To: kasperd@daimi.au.dk (Kasper Dupont)
Date: Wed, 22 May 2002 23:02:38 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CEBEA42.A614EBB5@daimi.au.dk> from "Kasper Dupont" at May 22, 2002 08:58:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AeBq-0002ve-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> write might be the easy case. But what about read?
> Is a failing read allowed to change the userspace
> memory?

Dave actually tried this with the UDP receive code. The answer appears to be
yes but not everything likes it when it occurs
