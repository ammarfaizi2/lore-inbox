Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132572AbRAYMPR>; Thu, 25 Jan 2001 07:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132733AbRAYMPH>; Thu, 25 Jan 2001 07:15:07 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:46068 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S132572AbRAYMOv>; Thu, 25 Jan 2001 07:14:51 -0500
Date: Thu, 25 Jan 2001 12:14:48 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: bert hubert <ahu@ds9a.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <20010125114201.A32526@home.ds9a.nl>
Message-ID: <Pine.SOL.4.21.0101251213100.651-100000@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jan 2001, bert hubert wrote:

> On Thu, Jan 25, 2001 at 09:06:33AM +0000, James Sutherland wrote:
> 
> > performance than it would for an httpd, because of the long-lived
> > sessions, but rewriting it as a state machine (no forking, threads or
> > other crap, just use non-blocking I/O) would probably make much more
> > sense.
> 
> From a kernel coders perspective, possibly. But a lot of SMB details are
> pretty convoluted. Statemachines may produce more efficient code but can be
> hell to maintain and expand. Bugs can hide in lots of corners.

I said they were good from a performance PoV - I didn't say they were
easy! Obviously there are reasons why the Samba guys have done what they
have. In fact, some parts of Samba ARE implemented as state machines to
some extent; presumably the remainder were considered too difficult to
reimplement that way for the time being.


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
