Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262634AbUFBNdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbUFBNdg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 09:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbUFBNdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 09:33:36 -0400
Received: from zero.aec.at ([193.170.194.10]:9479 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262634AbUFBNd2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 09:33:28 -0400
To: <rol@as2917.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: TCP retransmission : how to detect from an application ?
References: <22DFj-7Zd-1@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 02 Jun 2004 15:33:22 +0200
In-Reply-To: <22DFj-7Zd-1@gated-at.bofh.it> (Paul Rolland's message of "Wed,
 02 Jun 2004 15:10:05 +0200")
Message-ID: <m3zn7m5bkt.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul Rolland" <rol@as2917.net> writes:

> I've an application that is establishing TCP connection, and exchanges some
> data.
> However, from time to time, I suspect there are some packet loss, which are
> corrected by the kernel (hell, TCP is reliable, isn't it :-), but I'd like
> to know if an application can detect this (well, I don't want to be notified
> of a packet loss once detected, but I'd like to get some stats before
> closing
> the connection).
>
> Is there something possible ? Some ioctl ? Some /proc/magic-interface ?

RTFM. man tcp -> TCP_INFO 

-Andi

