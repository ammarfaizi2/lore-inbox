Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278072AbRJVHsL>; Mon, 22 Oct 2001 03:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278061AbRJVHsB>; Mon, 22 Oct 2001 03:48:01 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37895 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278073AbRJVHru>; Mon, 22 Oct 2001 03:47:50 -0400
Subject: Re: Has anyone run the Connectathon Testsuite recently?
To: hjl@lucon.org (H . J . Lu)
Date: Mon, 22 Oct 2001 08:54:20 +0100 (BST)
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org (linux kernel),
        alan@redhat.com
In-Reply-To: <20011021232452.A2473@lucon.org> from "H . J . Lu" at Oct 21, 2001 11:24:52 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vZue-00012y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Connectathon Testsuite against the Linux and none-Linux server. I
> believe both NFS server and client are broken in 2.4.9-6. See
> 
> http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=54868
> 
> Now the question is how bad the current Linus/AC kernels are?

Hopefully pretty close since there isn't much NFS related difference between
vanilla and -ac currently. The -ac client has the NFS inode structure in its 
own slab being the major change

Alan
