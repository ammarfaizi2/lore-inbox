Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129464AbRBAANl>; Wed, 31 Jan 2001 19:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129679AbRBAANb>; Wed, 31 Jan 2001 19:13:31 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:31249 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129464AbRBAANR>; Wed, 31 Jan 2001 19:13:17 -0500
Message-Id: <200102010014.f110ESl11703@bastable.devel.redhat.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: tux-list@redhat.com
Cc: linux-kernel@vger.kernel.org, editor@lwn.net, scoop@freshmeat.net,
        editor@linuxtoday.com
Subject: Announcement: TUX 2.0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 31 Jan 2001 19:14:28 -0500
From: "Michael K. Johnson" <johnsonm@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


TUX 2.0 is now available for download at the following URL:

    ftp://ftp.redhat.com/pub/redhat/tux/tux-2.0/

The TUX 2.0 release is an incremental upgrade to TUX 1.0 and keeps
source-code level compatibility with user-space modules.

A number of incremental enhancements have been made:

- True zero-copy disk reads: Whereas TUX 1.0 copied files into a temporary
  buffer, TUX 2.0 is integrated with the page cache and thus uses zero-copy
  block IO.

- Generic zero-copy network writes: TUX 2.0 uses the generic zero-copy TCP
  framework.

- Zero-copy parsing:  Where possible, TUX parses input packets directly.
  Even in RAM-limited situations, TUX now does full, back-to-back
  zero-copy I/O.

Other changes include:

- Enhanced user-space utilities and module support.

- Mass virtual hosting support. The host-based virtual server patch has
  been added to TUX. There is no limit on the number of virtual hosts
  supported, only RAM and diskspace.

- CGIs can be bound to particular CPUs or can be left unbound.

- A number of bugs were fixed which caused performance problems - TUX 2.0
  is now significantly faster than TUX 1.0!


Those interested in TUX usage or development are welcome, if they have
not already done so, to join the TUX mailing list at:

    tux-list@redhat.com

You can subscribe using the command:

    echo subscribe | mail tux-list-request@redhat.com

Or you can use the web interface at

    http://www.redhat.com/mailing-lists/

Thanks for your interest,

-- Ingo and Michael

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
