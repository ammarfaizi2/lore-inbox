Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288958AbSBZXcK>; Tue, 26 Feb 2002 18:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288801AbSBZXbu>; Tue, 26 Feb 2002 18:31:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46344 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288557AbSBZXbn>;
	Tue, 26 Feb 2002 18:31:43 -0500
Message-ID: <3C7C1A88.AA6CE5DD@zip.com.au>
Date: Tue, 26 Feb 2002 15:30:16 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>
CC: linux-kernel@vger.kernel.org
Subject: Re: assertion failure : ext3 & lvm , 2.4.17 smp & 2.4.18-ac1 smp
In-Reply-To: <Pine.LNX.4.44.0202270017250.5280-100000@tassadar.physics.auth.gr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dimitris Zilaskos wrote:
> 
> Assertion failure in do_get_write_access() at transaction.c:730: "(((jh2bh(jh))->b_state & (1UL << BH_Uptodate)) != 0)"

This was fixed in the ext3 patch which went into 2.4.18-pre5

-
