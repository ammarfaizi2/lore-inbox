Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263725AbTDTWhJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 18:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbTDTWhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 18:37:09 -0400
Received: from zork.zork.net ([66.92.188.166]:45189 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S263725AbTDTWhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 18:37:09 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: OpenSSH protocol version 2 doesn't support Kerberos
 authentication
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: DICTO SIMPLICITER, ARGUMENTUM AD
 BACULUM
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sun, 20 Apr 2003 23:49:10 +0100
In-Reply-To: <1050878426.614.4.camel@teapot.felipe-alfaro.com> (Felipe
 Alfaro Solana's message of "21 Apr 2003 00:40:27 +0200")
Message-ID: <6un0iklr89.fsf@zork.zork.net>
User-Agent: Gnus/5.090019 (Oort Gnus v0.19) Emacs/21.2 (gnu/linux)
References: <1050878426.614.4.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> writes:

> Such situation led me to browse the OpenSSH sources and, to my dismay, I
> have found that Kerberos V5 authentication is *not* implemented for
> protocol version 2, only in protocol version 1. Just take a look at
> sshconnect1.c and sshconnect2.c to check.

I don't use Kerberos, but Debian ships a ssh-krb5 package which claims
to support authentication via Kerberos for both v1 and v2 connections.

http://packages.debian.org/unstable/net/ssh-krb5.html

-- 
Sean Neakums - <sneakums@zork.net>
