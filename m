Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279865AbRJ3Eov>; Mon, 29 Oct 2001 23:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279866AbRJ3Eol>; Mon, 29 Oct 2001 23:44:41 -0500
Received: from longsword.omniti.com ([216.0.51.134]:53010 "EHLO
	longsword.omniti.com") by vger.kernel.org with ESMTP
	id <S279865AbRJ3Eoh>; Mon, 29 Oct 2001 23:44:37 -0500
Message-ID: <3BDE3174.7718D64B@omniti.com>
Date: Mon, 29 Oct 2001 23:49:56 -0500
From: Robert Scussel <rscuss@omniti.com>
Reply-To: rscuss@omniti.com
Organization: OmniTI, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com
CC: andre@sam.com.br, linux-kernel@vger.kernel.org, jesus@omniti.com
Subject: Re: linux-2.4.13 high SWAP
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just thought that I would add our experience.

We have experienced the same kind of swap symptoms described, however we
have no mounted tmpfs, or ramfs partitions. We have, in fact,
experienced the same symptoms on the 2.4.2,2.4.5,2.4.7 and 2.4.12
kernel, haven't yet tried the 2.4.13 kernel.  The symptoms include hung
processes which can not be killed, system cannot right to disk, and
files accessed during this time are filled with binary zeros.  As sync
does not work as well, the only resolution is to do a reboot -f -n.

All systems are comprised of exclusively SGI XFS partitions, with dual
pentium II/III processors.

Any insight would be helpful,

Robert Scussel
--
Robert Scussel
1024D/BAF70959/0036 B19E 86CE 181D 0912  5FCC 92D8 1EA1 BAF7 0959
