Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262969AbUDDXsr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 19:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262962AbUDDXsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 19:48:47 -0400
Received: from voicebook.com ([128.121.231.235]:9996 "EHLO voicebook.com")
	by vger.kernel.org with ESMTP id S262969AbUDDXsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 19:48:46 -0400
Subject: Re: 2.6.5-aa2
From: Marcello Barnaba <l.barnaba@openssl.it>
Reply-To: l.barnaba@openssl.it
To: linux-kernel@vger.kernel.org
In-Reply-To: <20040404205848.GL482@dualathlon.random>
References: <20040404205848.GL482@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: SoftMedia s.c.r.l.
Message-Id: <1081122523.2668.6.camel@nowhere.openssl.softmedia.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 05 Apr 2004 01:48:43 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-04-04 at 22:58, Andrea Arcangeli wrote:
> Only in 2.6.5-aa2: xfs-vmtruncate
> 
> 	Fix truncate to drop the mappings before removing the page from
> 	pagecache (should fix the WARN_ON). From Nathan Scott.

I confirm that the WARN_ON() problem disappeared after applying -aa2.
Nice work :).
-- 
Marcello Barnaba - SoftMedia S.c.r.l.    ::    Mobile: +39 (340) 3698342
Via Cardassi, 26 - 70121 Bari            ::    Phone:  +39 (080) 5237112
pub 1024D/F04476A2 :: 6807 EEA5 7F97 AC9A D8EF  AE73 64CD 71A2 F044 76A2
