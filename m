Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbTEYHtm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 03:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbTEYHtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 03:49:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9226 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261444AbTEYHtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 03:49:42 -0400
Date: Sun, 25 May 2003 09:02:47 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Ben Collins <bcollins@debian.org>
Cc: Patrick Mochel <mochel@osdl.org>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Resend [PATCH] Make KOBJ_NAME_LEN match BUS_ID_SIZE
Message-ID: <20030525090247.A22027@flint.arm.linux.org.uk>
Mail-Followup-To: Ben Collins <bcollins@debian.org>,
	Patrick Mochel <mochel@osdl.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20030513071412.GS433@phunnypharm.org> <Pine.LNX.4.44.0305130808040.9816-100000@cherise> <20030516002059.GE433@phunnypharm.org> <20030525000701.GG504@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030525000701.GG504@phunnypharm.org>; from bcollins@debian.org on Sat, May 24, 2003 at 08:07:01PM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 24, 2003 at 08:07:01PM -0400, Ben Collins wrote:
> Given that the problem with KOBJ_NAME_LEN == 20 affecting one snd driver
> has so far only been explained as a compiler bug, can I suggest this
> patch be applied?

No one has confirmed that it is a compiler bug yet.  We only suspect
that something in the yamaha driver is getting miscompiled.  We don't
know what, we don't know how, we don't know why.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

