Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130202AbRAXIpJ>; Wed, 24 Jan 2001 03:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130685AbRAXIoi>; Wed, 24 Jan 2001 03:44:38 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:51373 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S130172AbRAXIoZ>; Wed, 24 Jan 2001 03:44:25 -0500
Date: Wed, 24 Jan 2001 08:44:23 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Sasi Peter <sape@iq.rulez.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.LNX.4.30.0101240156150.3522-100000@iq.rulez.org>
Message-ID: <Pine.SOL.4.21.0101240843270.27813-100000@green.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jan 2001, Sasi Peter wrote:

> On 14 Jan 2001, Linus Torvalds wrote:
> 
> > The only obvious use for it is file serving, and as high-performance
> > file serving tends to end up as a kernel module in the end anyway (the
> > only hold-out is samba, and that's been discussed too), "sendfile()"
> > really is more a proof of concept than anything else.
> 
> No plans for samba to use sendfile? Even better make it a tux-like module?
> (that would enable Netware-Linux like performance with the standard
> kernel... would be cool afterall ;)

AIUI, Jeff Merkey was working on loading "userspace" apps into the kernel
to tackle this sort of problem generically. I don't know if he's tried it
with Samba - the forking would probably be a problem...


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
