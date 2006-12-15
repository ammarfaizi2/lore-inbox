Return-Path: <linux-kernel-owner+w=401wt.eu-S965296AbWLOXsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965296AbWLOXsU (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 18:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965299AbWLOXsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 18:48:20 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:62899 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965296AbWLOXsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 18:48:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T9qRX+orOllfrTXBzr7rhSDbfaJk57DpxwXuyMcnFhYwJP+Ah9Q8orBr7r5YXOdc6Xr+ij7BBNemFEtG1lk68TGpkJdeqV4Ns9hoKoyffJgjkXkyllHmi3IVB+RrGI2P8d9CubZGNIMOqQNODSTzGxCQq8vOD8tCyGLlGGT6Ggc=
Message-ID: <5a4c581d0612151548j67664f18o8439ea3c4aaea702@mail.gmail.com>
Date: Sat, 16 Dec 2006 00:48:19 +0100
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Jarek Poplawski" <jarkao2@o2.pl>,
       "Alessandro Suardi" <alessandro.suardi@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-git19: lockdep messages on console
In-Reply-To: <20061215073514.GA1594@ff.dom.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5a4c581d0612121149h4695dd51sd9cfbef8a3ef37f1@mail.gmail.com>
	 <20061215073514.GA1594@ff.dom.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/06, Jarek Poplawski <jarkao2@o2.pl> wrote:
> On 12-12-2006 20:49, Alessandro Suardi wrote:
> > Very shortly after boot on my K7-800 running up-to-date FC6
> > and 2.6.19-git19; didn't happen in 2.6.19-vanilla:
> ...
> > [  134.915521] INFO: trying to register non-static key.
> > [  134.915890] the code is fine but needs lockdep annotation.
> > [  134.916249] turning off the locking correctness validator.
>
> It looks like repaired in 2.6.20-rc1 by this:
>
> [patch] lockdep: fix seqlock_init()

Thanks Jarek, I don't seem to get it in -git20 already.

Ciao,

--alessandro

"...when I get it, I _get_ it"

     (Lara Eidemiller)
