Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262467AbVDLPOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262467AbVDLPOH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 11:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbVDLPK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 11:10:59 -0400
Received: from rev.193.226.232.28.euroweb.hu ([193.226.232.28]:57822 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262400AbVDLPAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 11:00:07 -0400
To: jamie@shareable.org
CC: dan@debian.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <20050412143237.GB10995@mail.shareable.org> (message from Jamie
	Lokier on Tue, 12 Apr 2005 15:32:37 +0100)
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
References: <20050411114728.GA13128@infradead.org> <E1DL08S-0008UH-00@dorka.pomaz.szeredi.hu> <20050411153619.GA25987@nevyn.them.org> <E1DL1Gj-000091-00@dorka.pomaz.szeredi.hu> <20050411181717.GA1129@nevyn.them.org> <E1DL4J4-0000Py-00@dorka.pomaz.szeredi.hu> <20050411192223.GA3707@nevyn.them.org> <E1DL51J-0000To-00@dorka.pomaz.szeredi.hu> <20050411221324.GA10541@nevyn.them.org> <E1DLEsQ-00015Z-00@dorka.pomaz.szeredi.hu> <20050412143237.GB10995@mail.shareable.org>
Message-Id: <E1DLMrh-0001lm-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 Apr 2005 16:59:45 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Note that NFS checks the permissions on _both_ the client and server,
> for a reason.

Does it?  If I read the code correctly the client checks credentials
supplied by the server (or cached).  But the server does the actual
checking of permissions.

Am I missing something?

Thanks,
Miklos
