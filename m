Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVFAJhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVFAJhM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 05:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVFAJen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 05:34:43 -0400
Received: from nproxy.gmail.com ([64.233.182.196]:6525 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261363AbVFAJdd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 05:33:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UzM9IrE1KEChy68nDA+uTqgW87SEXrgkqoO3wRaNV9iM+WRkndkahZ6qyuJpTV1sWXstFN3B5CEfqTM/CbzMN6pn1QtfOJ+Hw1pqBqAvyT+76lWX2F+zjYAyLqN8t1/PViG6Stto95CSTm+i1LbvSXqygZi062InksGleBIz4Z0=
Message-ID: <2cd57c90050601023358417bbd@mail.gmail.com>
Date: Wed, 1 Jun 2005 17:33:29 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC/PATCH 0/5] add execute in place support
Cc: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Carsten Otte <cotte@freenet.de>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, schwidefsky@de.ibm.com, akpm@osdl.org
In-Reply-To: <1115890981.16187.553.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <428216DF.8070205@de.ibm.com>
	 <1115828389.16187.544.camel@hades.cambridge.redhat.com>
	 <42823450.8030007@freenet.de>
	 <20050512085741.GA16361@wohnheim.fh-wedel.de>
	 <1115890981.16187.553.camel@hades.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/05, David Woodhouse <dwmw2@infradead.org> wrote:
> On Thu, 2005-05-12 at 10:57 +0200, Jörn Engel wrote:
> > In principle, both the block device abstraction and the mtd
> > abstraction fit your bill.  But jffs2 doesn't, so no in-kernel fs
> > could make use of a xip-aware mtd abstraction.
> >
> > Patching jffs2 for xip looks like a major effort, at best, and utterly
> > insane at worst.  I'd prefer not to go down that path.
> 
> You and me both. The time has definitely come to recognise that JFFS2
> needs replacing ;)

I'd say yaffs seems to be a good one. 

-- 
Coywolf Qi Hunt
http://ahbl.org/~coywolf/
