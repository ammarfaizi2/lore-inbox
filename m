Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264058AbUGYP0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264058AbUGYP0P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 11:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264012AbUGYP0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 11:26:15 -0400
Received: from main.gmane.org ([80.91.224.249]:50627 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264054AbUGYPY4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 11:24:56 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Marc Ballarin <Ballarin.Marc@gmx.de>
Subject: Re: [PATCH] Delete cryptoloop
Date: Sun, 25 Jul 2004 15:24:46 +0000 (UTC)
Message-ID: <loom.20040725T171924-629@post.gmane.org>
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com> <1090672906.8587.66.camel@ghanima> <41039CAC.965AB0AA@users.sourceforge.net> <1090761870.10988.71.camel@ghanima>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.139.254.199 (Mozilla/5.0 (compatible; Konqueror/3.2; Linux) (KHTML, like Gecko))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fruhwirth Clemens <clemens-dated-1091625872.c783 <at> endorphin.org> writes: 
 
>  
> On Sun, 2004-07-25 at 13:42, Jari Ruusu wrote: 
> > Fruhwirth Clemens wrote: 
> > > Second, modern ciphers like Twofish || AES are designed to resist 
> > > known-plaintext attacks. This is basically the FUD spread by Jari Rusuu. 
> >  
> > Ciphers are good, but both cryptoloop and dm-crypt use ciphers in insecure 
> > and exploitable way. 
> >  
> > This is not FUD. Fruhwirth, did you even try run the exploit code? 
> >  
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=107719798631935&w=2 
>  
> There is no use in running your code. It does not decipher any block 
> without the proper key. Where is the exploit?  
>  
 
Well, the obvious flaw is that an attacker can detect the presence of a 
watermarked file on an encrypted volume. This is not about decrypting files, 
merely proving their existence. 
 
Wheter this can be called an exploit does not matter. It definitely is a major 
hole. 
 
Marc 
 
 

