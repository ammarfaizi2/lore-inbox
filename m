Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262415AbVGLUvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbVGLUvd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 16:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbVGLUtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 16:49:19 -0400
Received: from web52001.mail.yahoo.com ([206.190.48.84]:3242 "HELO
	web52001.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262409AbVGLUs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 16:48:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Z14SzRckjbD1loh/ELHkiwzMkOPOrvmFnCZAY/LhiYCIwhNhDQARl4qCj9dhhxdvmIvpUkDYoPEdwfPA5zxd+eNAlBGO1OS3RRZeCOyVc4/DOmt/c8PO1ryPT9EP87OLwOZv3mKP3av7sOUOaKs+TRKsVPXOfZZQgqm7NhM7VBI=  ;
Message-ID: <20050712204822.84567.qmail@web52001.mail.yahoo.com>
Date: Tue, 12 Jul 2005 13:48:22 -0700 (PDT)
From: Konstantin Kudin <konstantin_kudin@yahoo.com>
Subject: Re: fdisk: What do plus signs after "Blocks" mean? 
To: Horst von Brand <vonbrand@inf.utfsm.cl>, lkml@dervishd.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <200507122019.j6CKJwxe021850@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Horst von Brand <vonbrand@inf.utfsm.cl> wrote:

 Guys, thanks a lot for the explanations!

 Actually, it seems like one can backup information on ALL partitions
by using the command "sfdisk -dx /dev/hdX". Supposedly, it reads not
only primary but also extended partitions. "sfdisk -x /dev/hdX" should
be then able to write whatever is known back to the disk.

 Konstantin



> DervishD <lkml@dervishd.net> wrote:
> 
> [...]
> 
> >     It's a good idea to have a copy of the partition table around,
> if
> > it is not simple (the one you had is NOT simple).
> 
> Be careful. What you'll get out of backing up the partition table is
> /only/
> the primary partitions, the others are handled by a weird russian
> doll of
> partitions-inside-partitions. AFAIR, the details were in the LILO
> docu.
> -- 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
