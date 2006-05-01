Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWEARxC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWEARxC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 13:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWEARxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 13:53:01 -0400
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96]:30801 "HELO
	smtp007.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932183AbWEARxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 13:53:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=jdBfuUmv5pS6eHu56jpjiSqc1tS+AtmsHhN1zaFQWRywaYJVdAgb+w+sZHTfjfvqzI+g7q4ROdtxuLvF+3tk9B7dbPHCEWYd6oIA9zaFVFpRfIG/sHOM3IuZS6NLAwZUAzpfDoY78lRvz09ewKth8dxH5I7VXCF3Vc1mNfHMls0=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH] UML - uml-makefile-nicer uses SYMLINK incorrectly
Date: Mon, 1 May 2006 19:52:35 +0200
User-Agent: KMail/1.8.3
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <200605011639.k41GdkGV004644@ccure.user-mode-linux.org>
In-Reply-To: <200605011639.k41GdkGV004644@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605011952.43733.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 May 2006 18:39, Jeff Dike wrote:
> Blaisorblade's uml-makefile-nicer makes a V=0 build say SYMLINK where
> what's happening is really a LINK.
>
> Signed-off-by: Jeff Dike <jdike@addtoit.com>

Good catch:

Acked-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
