Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbTJNOIg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 10:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262304AbTJNOIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 10:08:36 -0400
Received: from adsl-67-67-9-206.dsl.okcyok.swbell.net ([67.67.9.206]:51669
	"HELO homer.d-oh.org") by vger.kernel.org with SMTP id S262057AbTJNOIf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 10:08:35 -0400
From: "Alex Adriaanse" <alex_a@caltech.edu>
To: "Hans Reiser" <reiser@namesys.com>
Cc: <linux-kernel@vger.kernel.org>, <vs@thebsh.namesys.com>
Subject: RE: ReiserFS patch for updating ctimes of renamed files
Date: Tue, 14 Oct 2003 09:08:32 -0500
Message-ID: <JIEIIHMANOCFHDAAHBHOIEMGDAAA.alex_a@caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <3F8BB699.3070404@namesys.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Great.  Thanks a lot!

Where would I be able to download the patch that you guys will be producing
once it's through QA?  At ftp://ftp.namesys.com/pub/reiserfs-for-2.4/ or is
there some other place I can get it (e.g. BK/CVS/HTTP/FTP) before it's
posted at that link?

Thanks,

Alex

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Hans Reiser
Sent: Tuesday, October 14, 2003 3:41 AM
To: Anton Ertl
Cc: linux-kernel@vger.kernel.org; Andrew Morton; vs@thebsh.namesys.com;
jw schultz; Alex Adriaanse
Subject: Re: ReiserFS patch for updating ctimes of renamed files


I looked again at the definition of the difference between ctime and
mtime on the stat man page, and I think that updating ctime in response
to rename is as reasonable as updating it in response to changing the
number of links.

Ok, we will conform, and I will accept the kindly donated patch, along
with Andrew's optimization of our evaluation of CURRENT_TIME.  vs,
please add Andrew's suggested optimization and sent the result through
QA.  Thanks to all for your good advice.

--
Hans


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

