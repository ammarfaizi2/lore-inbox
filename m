Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318722AbSG0JQP>; Sat, 27 Jul 2002 05:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318723AbSG0JQP>; Sat, 27 Jul 2002 05:16:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56590 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318722AbSG0JQO>;
	Sat, 27 Jul 2002 05:16:14 -0400
Message-ID: <3D426588.6070704@mandrakesoft.com>
Date: Sat, 27 Jul 2002 05:19:04 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kees <kees@schoen.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19.rc3{8139too as module}
References: <Pine.LNX.4.33.0207271054120.8193-100000@schoen3.schoen.nl>
X-Enigmail-Version: 0.65.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kees wrote:
> Hi
> 
> I tried to use 8139too as module, but that failed. 4 mii_...... like
> mii_link_ok() could not be resolved (at load time).  As a compiled in
> driver it works ok.


It requires the mii.o module.  Use modprobe instead of insmod :)


