Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130054AbRBVUa5>; Thu, 22 Feb 2001 15:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129680AbRBVUar>; Thu, 22 Feb 2001 15:30:47 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:32006 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129599AbRBVUaa>; Thu, 22 Feb 2001 15:30:30 -0500
Date: 22 Feb 2001 21:04:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <7wNdSRv1w-B@khms.westfalen.de>
In-Reply-To: <20010222000755.A29061@atrey.karlin.mff.cuni.cz>
Subject: Re: [rfc] Near-constant time directory index for Ext2
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <3A94470C.2E54EB58@transmeta.com> <3A94435D.59A4D729@transmeta.com> <20010221235008.A27924@atrey.karlin.mff.cuni.cz> <3A94470C.2E54EB58@transmeta.com> <20010222000755.A29061@atrey.karlin.mff.cuni.cz>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mj@suse.cz (Martin Mares)  wrote on 22.02.01 in <20010222000755.A29061@atrey.karlin.mff.cuni.cz>:

> One could avoid this, but it would mean designing the whole filesystem in a
> completely different way -- merge all directories to a single gigantic
> hash table and use (directory ID,file name) as a key, but we were originally
> talking about extending ext2, so such massive changes are out of question
> and your log n access argument is right.

s/hash table/btree/ and you have just described the Macintosh HFS file  
system. (Incidentally, it stores file extent indices in a similar manner,  
with key = (file id, fork, offset).)


MfG Kai
