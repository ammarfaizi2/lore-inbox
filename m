Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288623AbSBMSxZ>; Wed, 13 Feb 2002 13:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288595AbSBMSxP>; Wed, 13 Feb 2002 13:53:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37138 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288622AbSBMSxC>;
	Wed, 13 Feb 2002 13:53:02 -0500
Message-ID: <3C6AB5D2.A7D665FE@zip.com.au>
Date: Wed, 13 Feb 2002 10:52:02 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Pavel Machek <pavel@suse.cz>, Jens Axboe <axboe@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
In-Reply-To: <20020211221102.GA131@elf.ucw.cz> <3C68F3F3.8030709@evision-ventures.com> <3C69750E.8BA2C6AB@zip.com.au> <3C6A4449.3030703@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> 
> >I suspect that if we remove these, we'll one day end up putting them back.
> >It is appropriate that we be able to control readahead characteristics
> >on a per-device and per-technology basis.
> >
> You are missing one simple thing: The removed values doen't control
> ANYTHING!

The file_readahead setting works as expected and as desired.  Or at
least it did a few weeks ago.

-
