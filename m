Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291026AbSCHENA>; Thu, 7 Mar 2002 23:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293695AbSCHEMv>; Thu, 7 Mar 2002 23:12:51 -0500
Received: from mail3.panix.com ([166.84.1.74]:62443 "HELO mail3.panix.com")
	by vger.kernel.org with SMTP id <S291026AbSCHEMq>;
	Thu, 7 Mar 2002 23:12:46 -0500
From: "R. Bernstein" <rocky@panix.com>
Message-ID: <15496.14909.786805.71538@panix3.panix.com>
Date: Thu, 7 Mar 2002 23:12:45 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Subject: audio channel routinng in "Linux CD-ROM Standard"?
X-Mailer: VM 6.90 under Emacs 20.7.1
Reply-To: rocky@panix.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was reading ``A Linux CD-ROM Standard'' of 12 March 1999
(/usr/src/linux/Documentation/cdrom/cdrom-standard.tex) in order to
understand how audio channel routing might be performed in this
standard. I don't see where it would be put in.

By "audio channel routing" I mean having the left channel routed to
the right (e.g. left monaural), or having the stereo channels come out
reversed. In looking at a CD-playing program xmcd, I see it has a
provision for a SCSI CDs to issue such a routing command, but when it
uses this protocol, it unconditionally disables this ability since it
doesn't seem to be part of the protocol. If you however enable
CONFIG_BLK_DEV_IDESCSI the routing can be set via the SCSI passthrough
ioctl mechanism -- but then why have a cdrom standard in the first
place? 

I don't know if this is the right place to direct inqueries as to the
future of this protocol. If this would better be directed elsewhere,
sorry, let me know where I should post a query. I sent a inquiry to
the email addresses in A Linux CD-ROM Standard and haven't heard back
from nary a one.

I am not subscribed to this forum, so I'd appreciate replies cc'd to
me.

Many thanks.
