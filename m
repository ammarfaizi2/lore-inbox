Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263250AbUJ2MJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263250AbUJ2MJz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 08:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263293AbUJ2MJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 08:09:55 -0400
Received: from [202.141.25.89] ([202.141.25.89]:17797 "EHLO
	cello.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S263250AbUJ2MFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 08:05:20 -0400
To: Danny Brow <dan@fullmotions.com>
Subject: Re: SSH and 2.6.9
References: <1098906712.2972.7.camel@hanzo.fullmotions.com>
	<Pine.LNX.4.61.0410272247460.3284@dragon.hygekrogen.localhost>
	<1098912301.4535.1.camel@hanzo.fullmotions.com>
	<1098913797.3495.0.camel@hanzo.fullmotions.com>
	<m3u0sfs0fm.fsf@rajsekar.pc>
	<1098985454.9722.9.camel@hanzo.fullmotions.com>
From: Rajsekar <raj--cutme--sekar@cse.iDELTHISitm.ernet.in>
Cc: linux-kernel@vger.kernel.org
Date: Fri, 29 Oct 2004 17:33:00 +0530
In-Reply-To: <1098985454.9722.9.camel@hanzo.fullmotions.com> (Danny Brow's
 message of "Thu, 28 Oct 2004 13:44:14 -0400")
Message-ID: <m3mzy5k9zf.fsf@rajsekar.pc>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am talking only about the file /dev/tty (IMHO you mistook it to mean /dev/ttyXX)
The permission should be 666 not 660 (for /dev/tty as its owner is always
root).

Try changing the permission of /dev/tty to 666 (rw-rw-rw-)



-- 
    Rajsekar

