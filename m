Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbTKZAkP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 19:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263870AbTKZAkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 19:40:15 -0500
Received: from pat.uio.no ([129.240.130.16]:16371 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263850AbTKZAkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 19:40:12 -0500
To: Matt Bernstein <mb/lkml@dcs.qmul.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6: can't lockf() over NFS
References: <Pine.LNX.4.58.0311251613230.20810@lucy.dcs.qmul.ac.uk>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 25 Nov 2003 19:39:50 -0500
In-Reply-To: <Pine.LNX.4.58.0311251613230.20810@lucy.dcs.qmul.ac.uk>
Message-ID: <shssmkcufmx.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Matt Bernstein <mb/lkml@dcs.qmul.ac.uk> writes:

     > I can't get Debian testing to log in to GNOME when home
     > directories are mounted over NFS (Linux 2.6 client -> Linux
     > 2.4-ac server). It claims not to be able to lock a file..

IIRC Debian had some issues with rpc.statd. They were using some
incorrect compilation options. Try grabbing a newer version from
'unstable'.

Cheers,
  Trond
