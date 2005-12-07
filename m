Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbVLGQQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbVLGQQW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 11:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbVLGQQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 11:16:22 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:39567 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751188AbVLGQQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 11:16:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=5GQqbe8GBTvp0JhinAKDbqLNrVAHLFbLfkLZiU9uNt2RYFFO0O42yzKPzt/jdxYaw3oiIHIu95mTOTQK8fY9SGB9ENKwnF//jwxfVky6ng/0nvKOs6bfCcuit1E9UPemOMXc+6EW0mF2Nkw6zlrYhlzehSXRLzqAu96Q0sjh3Mo=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] um: fix compile error for tt
Date: Wed, 7 Dec 2005 17:16:05 +0100
User-Agent: KMail/1.8.3
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, jdike@karaya.com
References: <1133900650.3279.9.camel@localhost> <200512071038.04958.blaisorblade@yahoo.it> <Pine.LNX.4.58.0512071538230.22525@sbz-30.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.58.0512071538230.22525@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512071716.08637.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 December 2005 14:39, Pekka J Enberg wrote:
> Hi,
>
> On Wed, 7 Dec 2005, Blaisorblade wrote:
> > Ok, fine, just a note - the header inclusion should be added to
> >
> > arch/um/include/um_uaccess.h
> >
> > where it is effectively used (the offending macros, using FIXADDR_USER_*,
> > are __access_ok_vsyscall.
> >
> > For the rest it's ok.
>
> Here's an updated patch.

ACK - Andrew, please merge (and queue for -linus), or notify if it needs to be 
resent. Thanks.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
