Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264909AbUEQG3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264909AbUEQG3V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 02:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264915AbUEQG3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 02:29:21 -0400
Received: from lac-1-82-66-8-145.fbx.proxad.net ([82.66.8.145]:38273 "EHLO
	vignemale.local.eukrea.com") by vger.kernel.org with ESMTP
	id S264909AbUEQG3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 02:29:20 -0400
From: Eric BENARD / Free <ebenard@free.fr>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.6 : bad PCI device ID for SiS ISA bridge => SiS900 eth0: Can not find ISA bridge
Date: Mon, 17 May 2004 08:29:14 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       webvenza@libero.it, dominik.karall@gmx.net
References: <200405162004.57041.ebenard@free.fr> <40A7E161.5060207@pobox.com>
In-Reply-To: <40A7E161.5060207@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405170829.15275.ebenard@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 May 2004 23:47, Jeff Garzik wrote:
> Are you suggesting
> a) the hardware PCI id changed from 0x0008 to 0x0018 when booting 2.6.6.
> 	or
> b) sis900.c changed when booting 2.6.6.
>
> If "a", the PCI id in sis900.c seems to be 0x0008 in both 2.4 and 2.6.
> And further, I did not see any changes to this line of code in while
> searching 2.6.2 -> 2.6.6 patches on ftp.kernel.org.  I would lean
> towards a solution that modified sis900.c to check for -both- 0x08 and
> 0x18.
>
This is what I mean in my email. 
Yes sis900.c should check for both 0x08 and 0x18.
But, I don't understand why the ID has changed (on the same hardware) between 
2.6.3 & 2.6.6 

Eric
