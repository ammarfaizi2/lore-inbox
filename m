Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263983AbTEJKtO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 06:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263997AbTEJKtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 06:49:14 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:5125 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S263983AbTEJKtN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 06:49:13 -0400
Date: Sat, 10 May 2003 12:54:43 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [ATM] [UPDATE] unbalanced exit path in Forerunner HE he_init_one() (and an iphase patch too!)
Message-ID: <20030510125443.A14897@electric-eye.fr.zoreil.com>
References: <20030510000222.A10796@electric-eye.fr.zoreil.com> <200305092339.h49NcYGi011242@locutus.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200305092339.h49NcYGi011242@locutus.cmf.nrl.navy.mil>; from chas@locutus.cmf.nrl.navy.mil on Fri, May 09, 2003 at 07:38:34PM -0400
X-Organisation: Marie's fan club - III
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chas williams <chas@locutus.cmf.nrl.navy.mil> :
[...]
> i hope you dont mind, but i really dislike the goto.  one is plenty. 

I am not fond of the 'test before destruction' approach when the tests 
could have been avoided. Anyway you maintain the driver on a regular basis,
you are free to choose the fix.

> attached is a cleanup for the iphase (i made a small addition -- i believe
> the MEMDUMP_XXXXXXREG cases are also guilty of dereferencing).

Yes.

--
Ueimor
