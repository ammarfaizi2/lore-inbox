Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267411AbUHRS1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267411AbUHRS1e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 14:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267429AbUHRS1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 14:27:34 -0400
Received: from the-village.bc.nu ([81.2.110.252]:17024 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267411AbUHRS10 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 14:27:26 -0400
Subject: Re: network regression using 2.6.8.x behind Cisco 1712
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?iso-8859-2?Q?Ond=F8ej_Sur=FD?= <ondrej@sury.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1092817247.5178.6.camel@ondrej.sury.org>
References: <1092817247.5178.6.camel@ondrej.sury.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-Id: <1092849905.26056.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 18 Aug 2004 18:25:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-08-18 at 09:20, Ondřej Surý wrote:
> It could be some bug in IOS, but it is triggered by some change between
> 2.6.7 and 2.6.8.  Any hints what should I try or where to look?
> I could try some -pre and -rc kernel to locate where this was
> introduced, but at least try to hint me which version should be
> considered, I am not so willing to compile all -preX and -rcX, but could
> do that if neccessary to hunt this regression.

echo "0" >/proc/sys/net/ipv4/tcp_window_scaling see if that helps. If so
then suspect somehting like the cisco or upstream router.

