Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293016AbSCAAsl>; Thu, 28 Feb 2002 19:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310268AbSCAAqy>; Thu, 28 Feb 2002 19:46:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37392 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310264AbSCAAp4>; Thu, 28 Feb 2002 19:45:56 -0500
Subject: Re: [PATCH] bluesmoke/MCE support optional
To: p_gortmaker@yahoo.com (Paul Gortmaker)
Date: Fri, 1 Mar 2002 00:11:57 +0000 (GMT)
Cc: marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
In-Reply-To: <3C7E465A.4B3F4D9@yahoo.com> from "Paul Gortmaker" at Feb 28, 2002 10:01:46 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16gaeU-0001di-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Meant to do this a while ago.  Could do it via adding "nosmoke.c"  :-)
> (similar to fs/noquot.c) instead of #ifdef in bluesmoke.c, if somebody
> had a strong preference one way or the other.
> 
> Patch is against 2.4.18, complete with Aunt Tillie(tm) help text, etc.

Is the MCE code big enough to justify this ? Last time I checked it was
1800 bytes 1000 of which were __init
