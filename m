Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291907AbSBAS4L>; Fri, 1 Feb 2002 13:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291913AbSBAS4C>; Fri, 1 Feb 2002 13:56:02 -0500
Received: from maila.telia.com ([194.22.194.231]:24797 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S291907AbSBASzz>;
	Fri, 1 Feb 2002 13:55:55 -0500
Message-Id: <200202011855.g11Itia20984@maila.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, Jens Axboe <axboe@suse.de>
Subject: Re: Errors in the VM - detailed
Date: Fri, 1 Feb 2002 19:52:43 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0202011708460.29576-100000@mustard.heime.net> <200202011847.g11Ilwa14845@maila.telia.com>
In-Reply-To: <200202011847.g11Ilwa14845@maila.telia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One more thing, that I think is important.

On Friday den 1 February 2002 19.44, Roger Larsson wrote:
> On Friday den 1 February 2002 17.11, Roy Sigurd Karlsbakk wrote:
> - - -
> About Jens patch:
>
> My feeling is that there should be (a lot) more  READA than READ.
> since sequential READ really only NEEDS one at a time.
>
> Number of READ limits the number of concurrent streams.
> And READA limits the maximum total read ahead.

With RAID as Roy uses this gets even worse!
READs has to be > concurrent streams * raid disks   [IMHO]
since each stream is splitted out on all disks...

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
