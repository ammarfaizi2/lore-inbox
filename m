Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313130AbSDOJeR>; Mon, 15 Apr 2002 05:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313131AbSDOJeQ>; Mon, 15 Apr 2002 05:34:16 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26899 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313130AbSDOJeQ>; Mon, 15 Apr 2002 05:34:16 -0400
Subject: Re: linux as a minicomputer ?
To: landley@trommello.org (Rob Landley)
Date: Mon, 15 Apr 2002 10:10:31 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), ldavidsen@tmr.com,
        hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
In-Reply-To: <20020415065501.3A687740@merlin.webofficenow.com> from "Rob Landley" at Apr 14, 2002 08:37:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16x2VM-0005kn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (I'll admit swap behavior sucks a lot less than it used to, but is this an 
> endorsement?  There's no attempt at all to make swapping fair with multiple 
> users on a box.  Maybe rmap will help here...)

The rmap VM has the needed infrastructure and can already enforce per process
rss limits. Once it can enforce some kind of per user rss limits you get what
is needed. 
