Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262743AbVCWDDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262743AbVCWDDd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 22:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbVCWDDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 22:03:32 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:59622 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S262743AbVCWDDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 22:03:21 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: Starting input devices
To: Carlos Silva <r3pek@r3pek.homelinux.org>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Wed, 23 Mar 2005 04:08:06 +0100
References: <fa.g31iata.1i0qpgc@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DDwE2-0002IB-LB@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Silva <r3pek@r3pek.homelinux.org> wrote:

> basically, what does he do to print this messages:
> 
> input: AT Translated Set 2 keyboard on isa0060/serio0
> input: SynPS/2 Synaptics TouchPad on isa0060/serio1

grepping for "Translated" would have revealed drivers/input/keyboard/atkbd.c

(Spoiler: It calls printk :)
