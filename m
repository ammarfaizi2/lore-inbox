Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267242AbTAAPNl>; Wed, 1 Jan 2003 10:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267245AbTAAPNl>; Wed, 1 Jan 2003 10:13:41 -0500
Received: from [81.2.122.30] ([81.2.122.30]:24071 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267242AbTAAPNl>;
	Wed, 1 Jan 2003 10:13:41 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301011521.h01FLq6r001565@darkstar.example.net>
Subject: Re: a few more "make xconfig" inconsistencies
To: szepe@pinerecords.com (Tomas Szepe)
Date: Wed, 1 Jan 2003 15:21:52 +0000 (GMT)
Cc: rpjday@mindspring.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030101145120.GL14184@louise.pinerecords.com> from "Tomas Szepe" at Jan 01, 2003 03:51:20 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another config problem I noticed a while ago:

In 2.5.53, under Old CD-ROM drivers (not SCSI, not IDE), if you select
"Matsushita/Panasonic/Creative, Longshine, TEAC CDROM support", the
help text says:

"This driver can support up to four CD-ROM controller cards, and each
card can support up to four CD-ROM drives; if you say Y here, you will
be asked how many controller cards you have."

The user is not prompted to specify how many controllers they have in
2.5.53, and in 2.4.20-pre2, there are separate options for the 2nd,
3rd, and 4th controllers.

However, I've looked through the code, and I'm not sure if >1
controller is actually supported anymore - a lot of the code for that
seems to be commented out in 2.4.20-pre2, and completely removed in
2.5.53.

John.



