Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129265AbQKLB46>; Sat, 11 Nov 2000 20:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129392AbQKLB4t>; Sat, 11 Nov 2000 20:56:49 -0500
Received: from duck.doc.ic.ac.uk ([146.169.1.46]:55055 "EHLO duck.doc.ic.ac.uk")
	by vger.kernel.org with ESMTP id <S129265AbQKLB4l>;
	Sat, 11 Nov 2000 20:56:41 -0500
To: tytso@mit.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: What protects f_pos?
In-Reply-To: <y7r8zqzqt71.fsf@sytry.doc.ic.ac.uk>
	<200011112354.eABNs0005918@trampoline.thunk.org>
From: David Wragg <dpw@doc.ic.ac.uk>
Date: 12 Nov 2000 01:56:39 +0000
In-Reply-To: tytso@mit.edu's message of "Sat, 11 Nov 2000 18:54:00 -0500"
Message-ID: <y7raeb69cmg.fsf@sytry.doc.ic.ac.uk>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tytso@mit.edu writes:
> This looks like it's a bug to me....  although if you have multiple
> threads hitting a file descriptor at the same time, you're pretty much
> asking for trouble.

Yes, I haven't been able to come up with an example that might trigger
this that wasn't dubious to begin with.  I'll raise this again at a
convenient time during 2.5.

David

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
