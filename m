Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317419AbSGOKdm>; Mon, 15 Jul 2002 06:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317421AbSGOKdl>; Mon, 15 Jul 2002 06:33:41 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59199 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S317419AbSGOKdl>; Mon, 15 Jul 2002 06:33:41 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andre Hedrick <andre@linux-ide.org>, andersen@codepoet.org,
       linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
References: <Pine.LNX.4.10.10207112158000.20499-100000@master.linux-ide.org>
	<3D2E6506.7080006@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 15 Jul 2002 04:24:54 -0600
In-Reply-To: <3D2E6506.7080006@zytor.com>
Message-ID: <m165zhp9u1.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Andre Hedrick wrote:
> > Nice, so you still have to strip and export to the transport layer.
> > Please expand on what you are going to talk to packetized and the associated
> > transport protocol restricted to the scope of storage.
> > Next count all the different personalitys associated with the discrete
> > transport layer.
> > If you are referring to Jens' pktcdvd interface out of block, it is no
> > more than a bypass of dealing with scsi.  It would allow direct access to
> > the physical transport without portions of OS mucking up things as it does
> > now.
> >
> 
> I'm talking specifically about ATAPI devices here.  As we have already covered,
> not all ATA devices are ATAPI, but unless I'm completely off the wall, ATAPI is
> SCSI over IDE, and should be able to be driven as such.  The lack of access to
> that interface using the established interface mechanisms just bites.

ATAPI is SCSI like C is C++.  There are strong similarities but they
are regulated by different groups, and have slightly different semantics.
Last I checked cdrecord already compensates for those differences but they
are there.

Eric

