Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279261AbRKNKeY>; Wed, 14 Nov 2001 05:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280415AbRKNKeE>; Wed, 14 Nov 2001 05:34:04 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:2330 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S279261AbRKNKeC>;
	Wed, 14 Nov 2001 05:34:02 -0500
Message-ID: <20011114113309.A21270@win.tue.nl>
Date: Wed, 14 Nov 2001 11:33:09 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        <linux-kernel@vger.kernel.org>
Cc: Andre Hedrick <andre@linux-ide.org>
Subject: Re: [PATCH] Re: linux readahead setting?
In-Reply-To: <Pine.LNX.4.30.0111131619230.1290-100000@mustard.heime.net> <200111140038.fAE0ctq11703@mailg.telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <200111140038.fAE0ctq11703@mailg.telia.com>; from Roger Larsson on Wed, Nov 14, 2001 at 01:37:05AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tuesday 13 November 2001 16:21, Roy Sigurd Karlsbakk wrote:

>> I heard linux does <= 32 page readahead from block devices
>> (scsi/ide/que?). Is there a way to double this?

Use  blockdev --setra N /dev/foo  for your favorite number N.
