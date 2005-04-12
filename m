Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262394AbVDLOlC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbVDLOlC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 10:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbVDLOhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 10:37:13 -0400
Received: from mail.shareable.org ([81.29.64.88]:10144 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262260AbVDLOdA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 10:33:00 -0400
Date: Tue, 12 Apr 2005 15:32:37 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: dan@debian.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Message-ID: <20050412143237.GB10995@mail.shareable.org>
References: <20050411114728.GA13128@infradead.org> <E1DL08S-0008UH-00@dorka.pomaz.szeredi.hu> <20050411153619.GA25987@nevyn.them.org> <E1DL1Gj-000091-00@dorka.pomaz.szeredi.hu> <20050411181717.GA1129@nevyn.them.org> <E1DL4J4-0000Py-00@dorka.pomaz.szeredi.hu> <20050411192223.GA3707@nevyn.them.org> <E1DL51J-0000To-00@dorka.pomaz.szeredi.hu> <20050411221324.GA10541@nevyn.them.org> <E1DLEsQ-00015Z-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DLEsQ-00015Z-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> The same is true for the case when you mount an sshfs.  Since you
> entered your password (or have a passwordless login to the server) you
> are authorized to browse the files on the server, but only with the
> capabilities you have there as a user.  The server does the
> authorization.  The same is true for an NFS mount btw.  It's not the
> client that checks the permissions.
> 
> So do you see why I argue in favor of having an option _not_ to check
> permissions on the client by the kernel?

Note that NFS checks the permissions on _both_ the client and server,
for a reason.

-- Jamie
