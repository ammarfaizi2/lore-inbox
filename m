Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316113AbSHBRhA>; Fri, 2 Aug 2002 13:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316187AbSHBRhA>; Fri, 2 Aug 2002 13:37:00 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:14468 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S316113AbSHBRg7>;
	Fri, 2 Aug 2002 13:36:59 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200208021736.VAA10023@sex.inr.ac.ru>
Subject: Re: question about CONFIG_IP_ACCEPT_UNSOLICITED_ARP
To: cfriesen@nortelnetworks.COM (Chris Friesen)
Date: Fri, 2 Aug 2002 21:36:20 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D4ABD12.BBAA0646@nortelnetworks.com> from "Chris Friesen" at Aug 2, 2 09:15:02 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I was looking at the arp code and noticed the CONFIG_IP_ACCEPT_UNSOLICITED_ARP
> option.
> 
> I'm a bit confused, however, since there is no way to enable this option without
> specifying it on the command line.  Is this by intent?  It seems to have been
> added back in 1998 in a patch by Thomas Koenig.

#ifdef was added by me. At the moment it is not a configuration option,
but rather comment. The code is not to be enabled.

Alexey
