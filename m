Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262559AbVF2TkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbVF2TkA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 15:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbVF2TjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 15:39:25 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:10789 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262486AbVF2Tce convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 15:32:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i0D8GhvsWf9W0WbqxxkuZKVb9nv+W0XXlkWgvTLasseLxkFiPtkySLK4xBk4NaPex6KmPv5TcWo/m81L3nsU/AC99TMriBWLJbiMr+/QFUssROJaYY8keYE0Q33fX+xcotVQOB+PLwY2EgycaRuPbEmcCDhEqJkU6WMQaH/iCRw=
Message-ID: <ec88f49305062912323a1ee1be@mail.gmail.com>
Date: Wed, 29 Jun 2005 21:32:32 +0200
From: =?ISO-8859-1?Q?Thomas_R=F6sner?= <dtrauma.lkml@gmail.com>
Reply-To: =?ISO-8859-1?Q?Thomas_R=F6sner?= <dtrauma.lkml@gmail.com>
To: David Masover <ninja@slaphack.com>
Subject: Re: reiser4 plugins
Cc: Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>, Valdis.Kletnieks@vt.edu,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <42BE5DB6.8040103@slaphack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl>
	 <42BCD93B.7030608@slaphack.com>
	 <200506251420.j5PEKce4006891@turing-police.cc.vt.edu>
	 <42BDA377.6070303@slaphack.com>
	 <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu>
	 <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com>
	 <e692861c05062522071fe380a5@mail.gmail.com>
	 <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I hereby throw myself into the neverending flames called "reiser4
plugins" - may it please the gods.

David Masover (who really could use pgp mime attatchments):
> So, the API becomes something like:
> 
> cat crypto/inflated/foo         # transparently decompressed
> cat crypto/raw/foo.gz           # raw, gzip-compressed

Wee, I've seen this before. Wait, its AVFS! But didn't AFVS work with
any underlying fs? Even nfs?

cd foo.zip#/bar/
cat foo.tgz#/bar/plonk.txt

There is no reason why there shouldn't be a gpg AVFS-plugin, too. OK,
AVFS worked via coda's redir.o and IMHO we need smth like this in 2.6.
But, apart from more efficient compression on disk (if that really
ever works) you didn't show any convincing use cases.

Or am I fundamentally wrong?

regards,
  Thomas
