Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264701AbUGGAjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264701AbUGGAjP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 20:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264725AbUGGAjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 20:39:15 -0400
Received: from chaos.analogic.com ([204.178.40.224]:24196 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264701AbUGGAjO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 20:39:14 -0400
Date: Tue, 6 Jul 2004 20:38:53 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: David Eger <eger@havoc.gtf.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 0xdeadbeef vs 0xdeadbeefL
In-Reply-To: <20040706215622.GA9505@havoc.gtf.org>
Message-ID: <Pine.LNX.4.53.0407062035040.16334@chaos>
References: <20040706215622.GA9505@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jul 2004, David Eger wrote:

> Is there a reason to add the 'L' to such a 32-bit constant like this?
> There doesn't seem a great rhyme to it in the headers...
>
> -dte

Well if you put the 'name' so we could search for the reason.....
It probably is used for magic to initialize long-words. Without
the L, you may get a 'C' warning error because numbers default to
'int'.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


