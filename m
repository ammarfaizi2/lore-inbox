Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVBVUqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVBVUqx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 15:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVBVUqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 15:46:52 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:38733 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261236AbVBVUqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 15:46:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=H9tN6C4aOXCi6CLe+sWkJ1bFnaK/9bbdHzaT0xamlfZwZ+rlG3Ja+xnv5yZAyZY6vc13a7JdCZKIFyDo34V+slYk1FD0WFTqysuRLsXj0rlGY7VNbGTDZ2dl3duERkp7Jnt+TFMtY9nHn0NWfsjuddtiu+Co0LRmoTtL3E3sTEE=
Message-ID: <93ca306705022212461f9e0d81@mail.gmail.com>
Date: Tue, 22 Feb 2005 14:46:44 -0600
From: Alex Adriaanse <alex.adriaanse@gmail.com>
Reply-To: Alex Adriaanse <alex.adriaanse@gmail.com>
To: "Marc A. Lehmann" <pcg@goof.com>, Andreas Steinmetz <ast@domdv.de>,
       Alex Adriaanse <alex.adriaanse@gmail.com>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: Odd data corruption problem with LVM/ReiserFS
In-Reply-To: <20050222194900.GB10968@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <93ca3067050220212518d94666@mail.gmail.com>
	 <4219C811.5070906@domdv.de> <20050222190149.GB9590@schmorp.de>
	 <421B8A69.8000903@domdv.de> <20050222194900.GB10968@schmorp.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2005 20:49:00 +0100, Marc A. Lehmann <pcg@goof.com> wrote:
> > >A reboot fixes this for both ext3 and reiserfs (i.e. the error is gone).
> > >
> >
> > Well, it didn't fix it for me. The fs was trashed for good. The major
> > question for me is now usability of md/dm for any purpose with 2.6.x.
> > For me this is a showstopper for any kind of 2.6 production use.
> 
> Well, I do use reiserfs->aes-loop->lvm/dm->md5/raid5, and it never failed
> for me, except once, and the error is likely to be outside reiserfs, and
> possibly outside lvm.

Marc, what about you, were you using dm-snapshot when you experienced
temporary corruption?

Alex
