Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314263AbSDRHlg>; Thu, 18 Apr 2002 03:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314264AbSDRHlf>; Thu, 18 Apr 2002 03:41:35 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:37899 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S314263AbSDRHlf>; Thu, 18 Apr 2002 03:41:35 -0400
Message-ID: <3CBE78A0.D5AD8AC2@aitel.hist.no>
Date: Thu, 18 Apr 2002 09:41:20 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.8-dj1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE/raid performance
In-Reply-To: <Pine.LNX.4.21.0204171108480.3300-100000@ns> <E16xrfQ-0002VF-00@the-village.bc.nu> <20020417102722.B26720@vger.timpanogas.org> <20020417134716.D10041@borg.org> <20020417232634.GC574@matchmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:

> I'd imagine that IDE would need some protocol spec changes before this could
> be supported (at least a "spin the drive up" message...).
> 
Exists already.  You may use hdparm to tell IDE drives
to spin up and down or even set a timeout.  This is
mostly for power-saving or no-noise setups.

So they could indeed add a jumper to IDE drives to let them
power up in the spun-down state.  But that's not what
the vast majority of one-disk users want.

Helge Hafting
