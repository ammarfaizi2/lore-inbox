Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129539AbRBUV2k>; Wed, 21 Feb 2001 16:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129691AbRBUV2a>; Wed, 21 Feb 2001 16:28:30 -0500
Received: from dns-229.dhcp-248.nai.com ([161.69.248.229]:6626 "HELO
	localdomain") by vger.kernel.org with SMTP id <S129624AbRBUV2P>;
	Wed, 21 Feb 2001 16:28:15 -0500
Message-ID: <XFMail.20010221132959.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010221220835.A8781@atrey.karlin.mff.cuni.cz>
Date: Wed, 21 Feb 2001 13:29:59 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
To: Martin Mares <mj@suse.cz>
Subject: Re: [rfc] Near-constant time directory index for Ext2
Cc: Linux-kernel@vger.kernel.org, tytso@valinux.com,
        Andreas Dilger <adilger@turbolinux.com>, hch@ns.caldera.de,
        ext2-devel@lists.sourceforge.net,
        Daniel Phillips <phillips@innominate.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 21-Feb-2001 Martin Mares wrote:
> Hello!
> 
>> Have You tried to use skiplists ?
>> In 93 I've coded a skiplist based directory access for Minix and it gave
>> very
>> interesting performances.
>> Skiplists have a link-list like performance when linear scanned, and overall
>> good performance in insertion/seek/delete.
> 
> Skip list search/insert/delete is O(log N) in average as skip lists are just
> a
> dynamic version of interval bisection. Good hashing is O(1).

To have O(1) you've to have the number of hash entries > number of files and a
really good hasing function.



> 
>                               Have a nice fortnight

To be sincere, here is pretty daylight :)



- Davide

