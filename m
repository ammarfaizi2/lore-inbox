Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265998AbTGJJK6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 05:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266007AbTGJJK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 05:10:58 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:56337 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265998AbTGJJK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 05:10:57 -0400
Subject: Re: NFS client errors with 2.5.74?
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: LKML <linux-kernel@vger.kernel.org>, trond.myklebust@fys.uio.no
In-Reply-To: <20030710054121.GB27038@mail.jlokier.co.uk>
References: <20030710054121.GB27038@mail.jlokier.co.uk>
Content-Type: text/plain
Message-Id: <1057829132.584.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 10 Jul 2003 11:25:33 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-10 at 07:41, Jamie Lokier wrote:
> I'm seeing quite a lot of NFS client errors with 2.5.74, connected to
> a server running 2.4.20-18.9 (Red Hat 9's current kernel).
> 
> All of the errors that I've observed the form of a write() or close()
> returning EIO.  rsync seeems to have a particularly tough time -
> could the unusual size of blocks which rsync writes be relevant?
> 
> There are some read errors too, as Mozilla failed to find my profile
> claiming it couldn't read the file (when I restarted Mozilla, it found
> it the second time), and Gnome Terminal was unable to read its
> preferences file, but I didn't catch any specific read() errors.
> 
> I tried this command to see if the is a protocol error while running
> Ethereal:
> 
> [jamie@dual jamie]$ cp .mirMail.bjl1/INBOX .mirMail.bjl1/JBOX
> cp: closing `.mirMail.bjl1/JBOX': Input/output error

Any chance you are using "hard" NFS mounts?

