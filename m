Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030317AbWGZBeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030317AbWGZBeG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 21:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030347AbWGZBeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 21:34:06 -0400
Received: from rialto-h50.host.net ([64.135.31.50]:17331 "EHLO
	mail.ultrawaves.com") by vger.kernel.org with ESMTP
	id S1030317AbWGZBeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 21:34:05 -0400
Message-ID: <44C6C688.2080106@lammerts.org>
Date: Tue, 25 Jul 2006 21:34:00 -0400
From: Eric Lammerts <eric@lammerts.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Chris Boot <bootc@bootc.net>
Cc: kernel list <linux-kernel@vger.kernel.org>, soekris-tech@lists.soekris.com
Subject: Re: [RFC][PATCH] LED Class support for Soekris net48xx
References: <44AF7B00.9060108@bootc.net> <44C2EB45.1050302@lammerts.org> <44C37DCF.2080205@bootc.net>
In-Reply-To: <44C37DCF.2080205@bootc.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Boot wrote:
> Eric Lammerts wrote:
>>         char *bios = __va(0xf0000);
>>
>>         for(i = 0; i < 0x10000 - 19; i++) {

> Hmm, very ugly indeed! Where did you dig those offsets up from? Are they 
> likely to work properly in non-Soekris devices?

That's where the standard PC BIOS ROM is located (0xf0000-0xfffff). I use 
the same kernel on normal PC mainboards too and haven't seen any problems 
so far.

Eric
