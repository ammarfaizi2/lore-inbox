Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131349AbRAXP36>; Wed, 24 Jan 2001 10:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131825AbRAXP3i>; Wed, 24 Jan 2001 10:29:38 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:45801 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S131349AbRAXP33>; Wed, 24 Jan 2001 10:29:29 -0500
Date: Wed, 24 Jan 2001 15:29:25 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Sasi Peter <sape@iq.rulez.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <200101241512.QAA01140@iq.rulez.org>
Message-ID: <Pine.SOL.4.21.0101241527370.13692-100000@yellow.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jan 2001, Sasi Peter wrote:

> > AIUI, Jeff Merkey was working on loading "userspace" apps into the 
> kernel
> > to tackle this sort of problem generically. I don't know if he's 
> tried it
> > with Samba - the forking would probably be a problem...
> 
> I think, that is not what we need. Once Ingo wrote, that since HTTP 
> serving can also be viewed as a kind of fileserving, it should be 
> possible to create a TUX like module for the same framwork, that serves 
> using the SMB protocol instead of HTTP...

I must admit I'm a bit sceptical - apart from anything else, Jeff's
approach allows a bug in the server software to blow the whole OS away,
instead of just quietly coring! (Or, worse still, trample on some FS
metadata in RAM... eek!) A TUX module would be a nice idea, although I
haven't even been able to find a proper TUX web page - Google just gave
page after page of mailing list archives and discussion about it :-(


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
