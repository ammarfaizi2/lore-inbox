Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262345AbSJIXFy>; Wed, 9 Oct 2002 19:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262312AbSJIXFx>; Wed, 9 Oct 2002 19:05:53 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:38023 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262157AbSJIXFv>;
	Wed, 9 Oct 2002 19:05:51 -0400
Subject: Why NFS server does not pass lock requests via VFS lock() op?
To: nfs@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.2a (Intl) 23 November 1999
Message-ID: <OF3AABFEC7.87E5D2A4-ON87256C4D.007E3028@us.ibm.com>
From: Juan Gomez <juang@us.ibm.com>
Date: Wed, 9 Oct 2002 16:11:19 -0700
X-MIMETrack: Serialize by Router on D03NM694/03/M/IBM(Release 6.0|September 26, 2002) at
 10/09/2002 17:11:19
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Could anyone remind me of why NFS kernel would not pass byte range lock
requests to the underlying filsystem at the server side?
I think another person at IBM (Brian?) submitted a patch for this but such
patch never got included in the distribution.

I think a patch to pass lock requests to the underlying filesystem does not
affect single node NFS servers and it enables us to
support clustered Linux-based NAS heads over distributed file systems.

Juan

