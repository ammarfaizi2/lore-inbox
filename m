Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263791AbTKFTxv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 14:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263792AbTKFTxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 14:53:51 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2179 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263791AbTKFTxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 14:53:50 -0500
Date: Thu, 6 Nov 2003 19:56:21 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200311061956.hA6JuL6V002039@81-2-122-30.bradfords.org.uk>
To: Linus Torvalds <torvalds@osdl.org>, bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0311061132010.1842-100000@home.osdl.org>
References: <Pine.LNX.4.44.0311061132010.1842-100000@home.osdl.org>
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Linus Torvalds <torvalds@osdl.org>:

> ide-scsi has always been broken. You should not use it, and indeed there 
> was never any good reason for it existing AT ALL. But because of a broken 
> interface to cdrecord, cdrecord historically only wanted to touch SCSI 
> devices. Ergo, a silly emulation layer that wasn't really worth it.

Hmmm, but ide-scsi is used for a lot more than cd recorders these
days.  Alan mentioned 'crazy' SATA devices back in April.

http://marc.theaimsgroup.com/?l=linux-kernel&m=105000779411632&w=2

(Not that I'm suggesting that it is particularly sane to deal with an
SATA connected printer by presenting it as a SCSI device, but I just
can't see how ide-scsi could successfully be removed now :-( )

John.
