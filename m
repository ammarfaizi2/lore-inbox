Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136403AbREDOpT>; Fri, 4 May 2001 10:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136412AbREDOpJ>; Fri, 4 May 2001 10:45:09 -0400
Received: from srv01s4.cas.org ([134.243.50.9]:63949 "EHLO srv01.cas.org")
	by vger.kernel.org with ESMTP id <S136403AbREDOpC>;
	Fri, 4 May 2001 10:45:02 -0400
From: Mike Harrold <mharrold@cas.org>
Message-Id: <200105041444.KAA16558@mah21awu.cas.org>
Subject: close()
To: linux-kernel@vger.kernel.org
Date: Fri, 4 May 2001 10:44:53 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have a server which runs on a machine that now runs the new 2.4 kernel.
Since upgrading we've seen periods where it seems to just hang for minutes
at a time (anywhere form 5 minutes to an hour). I was finally able to get
a core dump of the server during one of these periods and it appears that
the hang is occuring during a call to close().

Has anyone else seen anything like this? Kernel version is:

  Linux version 2.4.2-4GB (root@Pentium.suse.de)

Thanks,

/Mike


