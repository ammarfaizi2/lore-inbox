Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbTHZSUp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 14:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbTHZSUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 14:20:45 -0400
Received: from 66-65-113-21.nyc.rr.com ([66.65.113.21]:29390 "EHLO
	siri.morinfr.org") by vger.kernel.org with ESMTP id S261226AbTHZSUo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 14:20:44 -0400
Date: Tue, 26 Aug 2003 14:21:02 -0400
From: Guillaume Morin <guillaume@morinfr.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend #1] fix cu3088 group write
Message-ID: <20030826182101.GF1111@siri.morinfr.org>
Mail-Followup-To: Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
References: <mi9I.54n.13@gated-at.bofh.it> <oqcQ.6L8.11@gated-at.bofh.it> <200308261804.h7QI4OxB057826@d12relay02.megacenter.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200308261804.h7QI4OxB057826@d12relay02.megacenter.de.ibm.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dans un message du 25 aoû à 12:47, Arnd Bergmann écrivait :
> Your fix doesn't look right either. The input string should not be
> longer than BUS_ID_SIZE, including the trailing zero.  AFAICS, the
> correct way to solve this is the patch below, but I did not test it.

Well, I did not know that BUS_ID_SIZE was including the trailing zero.
The name does not appear to suggest that. BUS_ID_LEN would have been a
better chose for that imho. 

I don't know what you call "not right". My fix was the safest bet. It is
right but yours is cleaner.

-- 
Guillaume Morin <guillaume@morinfr.org>

              Marry me girl, be my only fairy to the world (RHCP)
