Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130141AbRBZUmk>; Mon, 26 Feb 2001 15:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130166AbRBZUmc>; Mon, 26 Feb 2001 15:42:32 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:37647 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130141AbRBZUmK>; Mon, 26 Feb 2001 15:42:10 -0500
Message-ID: <001e01c0a034$bb74c730$f6976dcf@nwfs>
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
To: "Guest section DW" <dwguest@win.tue.nl>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: "Andreas Jellinghaus" <aj@dungeon.inka.de>, <linux-kernel@vger.kernel.org>,
        <aeb@cwi.nl>
In-Reply-To: <20010225163534.A12566@dungeon.inka.de> <20010225224729.A16353@win.tue.nl> <002201c09f87$5ce75640$f6976dcf@nwfs> <20010226041156.A16707@win.tue.nl> <20010226112407.C23495@vger.timpanogas.org> <20010226211150.A17477@win.tue.nl>
Subject: Re: partition table: chs question
Date: Mon, 26 Feb 2001 13:43:10 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Guest section DW" <dwguest@win.tue.nl>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>; "Andreas Jellinghaus"
<aj@dungeon.inka.de>; <linux-kernel@vger.kernel.org>; <aeb@cwi.nl>
Sent: Monday, February 26, 2001 1:11 PM
Subject: Re: partition table: chs question


> On Mon, Feb 26, 2001 at 11:24:07AM -0700, Jeff V. Merkey wrote:
> > On Mon, Feb 26, 2001 at 04:11:56AM +0100, Guest section DW wrote:
>
> > > (See http://www.win.tue.nl/~aeb/partitions/partition_types-1.html )
> > > Are types 57 and 77, labeled "VNDI Partition", actually in use?
> >
> > No.  They are not.  65, and 77 are the ones in use.  Novell was using
> > 67 for Wolf Mountain, but for NSS, they are exclusively using 69.
>
> Wait! 57 and 77 are not in use, but 65 and 77 are?
> (Is the second 77 a typo for 66 or 67?)
>
> A lot of partition IDs are attributed to Novell.
> 64 (Netware 286) and 65 (Netware 386) are well established, and
> you tell me 66 is Netware SMS, 67 is Wolf Mountain and 69 is Netware NSS.
> But also 51 and 68 occur in reports. Do you know anything about those?

Novell is assigned block 60-70 by some committee way back in the mid-1980's.
51 is not legal for them, I would like to look at this one.   Any numbers in
range 60-70 they can and do use, though most are experimental.  66 and 64
are no longer used, but older stuff may use them.

77 is one we are using internally for M2FS/M2CS partitions.  VNDI can be
dropped.

:-)

Jeff



>
> Andries

