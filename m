Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276359AbRJPPx7>; Tue, 16 Oct 2001 11:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276350AbRJPPxs>; Tue, 16 Oct 2001 11:53:48 -0400
Received: from green.csi.cam.ac.uk ([131.111.8.57]:2214 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S276359AbRJPPxd>; Tue, 16 Oct 2001 11:53:33 -0400
Date: Tue, 16 Oct 2001 16:53:39 +0100 (BST)
From: James Sutherland <jas88@cam.ac.uk>
X-X-Sender: <jas88@green.csi.cam.ac.uk>
To: David Lang <dlang@diginsite.com>
cc: Jacques Gelinas <jack@solucorp.qc.ca>,
        Linux kernel list <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@suse.cz>
Subject: re: Re: Announce: many virtual servers on a single box
In-Reply-To: <Pine.LNX.4.40.0110150854500.4883-100000@dlang.diginsite.com>
Message-ID: <Pine.SOL.4.33.0110161652570.28170-100000@green.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2001, David Lang wrote:

> you mention problems with interaction if the main sandbox has a service
> listening on 0.0.0.0, what happens if a vserver does this (does it only
> see it's own IP addresses or does it interfere with other servers?)

It only sees its own IP address(es). If one vserver could interfere with
another like that, this would be rather a big hole in the vserver
isolation :)


James.

