Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbTEROin (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 10:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbTEROin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 10:38:43 -0400
Received: from pat.uio.no ([129.240.130.16]:57216 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262097AbTEROil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 10:38:41 -0400
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: David Howells <dhowells@warthog.cambridge.redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Subject: Re: [PATCH] PAG support, try #2
References: <Pine.LNX.4.44.0305140924040.3107-100000@home.transmeta.com>
	<19800.1052933820@warthog.warthog>
	<20030515131825.G672@nightmaster.csn.tu-chemnitz.de>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 18 May 2003 16:51:27 +0200
In-Reply-To: <20030515131825.G672@nightmaster.csn.tu-chemnitz.de>
Message-ID: <shs8yt4l34g.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de> writes:

     > On Wed, May 14, 2003 at 06:37:00PM +0100, David Howells wrote:
    >> And then you have to have some method of prioritisation. You
    >> may find that user dhowells has a token for
    >> (fs=AFS,cell=redhat.com) and group engineering has a token for
    >> (fs=AFS,cell=redhat.com). Which do you use?

     > Union of both. And remember to subtract negative ACLs from
     > positive ACLs. Prioritize users over groups in case of explicit
     > mention.

     > This is standard permission checking.

     > Hmm, sounds too simple, so it must be wrong ;-)

Quite. Now that you've done the math, please explain how this should
be implemented efficiently. These are *networked* filesystems...

Cheers,
  Trond
