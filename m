Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263591AbTKFNj3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 08:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbTKFNj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 08:39:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63437 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263591AbTKFNj1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 08:39:27 -0500
Message-ID: <3FAA4EF9.70704@pobox.com>
Date: Thu, 06 Nov 2003 08:39:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
CC: linux-kernel@vger.kernel.org
Subject: Re: mii broken for 3c59x ?
References: <Pine.LNX.4.51.0311052142040.19211@dns.toxicfilms.tv>
In-Reply-To: <Pine.LNX.4.51.0311052142040.19211@dns.toxicfilms.tv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Soltysiak wrote:
> Hi,
> 
> I have two 3com 3c905C-TX NICs in my linux box.
> I remember that mii-tool used to work.
> 
> Now, with 2.6.0-test9-bk8 it does not.
> 
> dns:~# mii-tool
> SIOCGMIIPHY on 'eth0' failed: Operation not supported
> SIOCGMIIPHY on 'eth1' failed: Operation not supported
> no MII interfaces found
> 
> What might be going on here? Did we have any recent changes in this,
> or maybe my software's outdated, or NICs broken ?
> It's Debian Sarge.
> 
> mii-tool.c 1.9 2000/04/28 00:56:08 (David Hinds)


Most likely you need to recompile mii-tool, because it's using old ioctls.

	Jeff



