Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292635AbSBUQb0>; Thu, 21 Feb 2002 11:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292641AbSBUQbR>; Thu, 21 Feb 2002 11:31:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12044 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292635AbSBUQbL>;
	Thu, 21 Feb 2002 11:31:11 -0500
Message-ID: <3C7520CD.D325A3DC@mandrakesoft.com>
Date: Thu, 21 Feb 2002 11:31:09 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: BK Kernel Hacking HOWTO
In-Reply-To: <3C751CB2.52110E58@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 3) Include a summary and "diffstat -p1" of each changeset that will be
> downloaded, when Linus issues a "bk pull".  The author auto-generates
> these summaries using "bk push -nl <parent> 2>&1", to obtain a listing
> of all the pending-to-send changesets, and their commit messages.

Two notes I wanted to get out before the rewrite:

1) The preferred format is likely to be a -single- diffstat followed by
a changeset, and

2) "bk changes -L <local-linus-repository>" is the preferred way to get
a listing of changesets not yet sent to Linus, not "bk push -nl"

A script should be appearing in the very near future, which generates
the desired for-Linus changeset format automatically.  In the medium
term future and beyond, BK itself will hopefully generate the text.

	Jeff




-- 
Jeff Garzik      | XXX FREE! secure AFSPC AK-47 unclassified CDC
Building 1024    | NATO SAS CDMA fun with filters Bellcore kibo SSL
MandrakeSoft     | high security goat clones infowar 2600 Magazine
