Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262683AbVCPQt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbVCPQt6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 11:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262684AbVCPQsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 11:48:53 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:31327 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S262682AbVCPQsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 11:48:42 -0500
Message-ID: <42386368.5030604@tls.msk.ru>
Date: Wed, 16 Mar 2005 19:48:40 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.11.x, EXTRAVERSION and module compatibility
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As far as I can see, the "super-stable" kernel releases
should not affect module ABI in any way, that is, a module
compiled for 2.6.11 or 2.6.11.2 should work with 2.6.11.4
and vise versa.  Ofcourse I'm talking about modules which
are out of the main kernel tree.

But.  EXTRAVERSION gets changed with every 2.6.11.x release,
thus making out-of-tree modules incompatible just because
they contain different kernel version tag.

The question is obvious: Is this a correct/intended behaviour?
Maybe, just maybe, EXTRAVERSION should not be taken into
account when desciding if a given module compiled for a
given kernel?

Thanks.

/mjt
