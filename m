Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264018AbTDJKQ3 (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 06:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264021AbTDJKQ3 (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 06:16:29 -0400
Received: from pat.uio.no ([129.240.130.16]:60344 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264018AbTDJKQ2 (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 06:16:28 -0400
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
Subject: Re: 2.5->2.4 nfs corrupts
References: <20030410013349.GC467@zip.com.au>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 10 Apr 2003 12:28:03 +0200
In-Reply-To: <20030410013349.GC467@zip.com.au>
Message-ID: <shs3ckqfxzg.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == cat  <cat@zip.com.au> writes:

     > nfs server: 2.4.21-pre2 nfs client: 2.5.67

     > Every now and then I have problems copying data to and from the
     > nfs mount. It can either result in aborted writes like this:

     > 15 [11:23:59] >> mv maestro.mpeg /share/funny mv: closing
     > `/share/funny/maestro.mpeg': Input/output error 15 [11:24:24]
     > >> cp maestro.mpeg /share/funny

Unless you are using soft mounts (in which case problem == user error)
I suggest you try the latest (as of last night - probably late
afternoon Oz-time) bitkeeper. It contains a patch that has been posted
several times on this list against a 2.5. NFS client read corruption.

Cheers,
  Trond
