Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263465AbTHXLFN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 07:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbTHXLFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 07:05:12 -0400
Received: from [212.18.235.100] ([212.18.235.100]:18816 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S263465AbTHXLFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 07:05:07 -0400
Subject: Re: 2.4.22-rc2-ac3 blew up
From: Justin Cormack <justin@street-vision.com>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030824025224.GF3740@rdlg.net>
References: <20030824025224.GF3740@rdlg.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 24 Aug 2003 12:05:10 +0100
Message-Id: <1061723111.10735.0.camel@lotte>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-08-24 at 03:52, Robert L. Harris wrote:
> 
> This morning I put 2.4.22-rc2-ac3 on a mail server.  About 5 mins ago
> the box blew up and we got this in a remote syslog:
> 
> Aug 23 22:04:08 mailserver1 kernel: Do you have a strange power sav ing mode enabled?
> Aug 23 22:04:08 mailserver1 kernel: Uhhuh. NMI received for unknown reason 21.
> Aug 23 22:04:08 mailserver1 kernel: Dazed and confused, but trying to continue
> 
> ACPI and AMP are NOT enabled.  I can attach the .config tomorrow if
> someone wants it once the box is back up.  It's a 4way P3-550 with
> 16Gigs of RAM.  Himem and 64Gig were the compiled options as well as it
> was compiled for P3.  Due to the way it locked up there wasn't anything
> else we could get debug wise.  This is a production box so we had to
> roll it back to the previous kernel and no-real debugging options are
> available.  We do have a machine which is identicle except it is 4Gigs
> of ram and instead of a raid0 of 4 disks totalling 200Gigs of space the
> other machine has a single disk of 400GB.

Have you got ECC errors set to NMI?

Justin


