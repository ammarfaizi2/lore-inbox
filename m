Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932668AbVISWB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932668AbVISWB0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 18:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbVISWB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 18:01:26 -0400
Received: from web51008.mail.yahoo.com ([206.190.38.139]:6801 "HELO
	web51008.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932668AbVISWBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 18:01:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=kV/wrrDUizDwjNgEu6B6WBYQGGwKtPppv3fKjXI8okLiZgYCbS8VrwD2mb60KFk8tCQ521SdeoTlUv7XtmYy6ScXR8LTu/U6v1CDvTk4xBQ/1+dxF+HvOrUcs+zIOZ7PQbmtosgiI2u9okRCXbGRLVj9Uv2zXyZ58P5g31wwksw=  ;
Message-ID: <20050919220120.41245.qmail@web51008.mail.yahoo.com>
Date: Mon, 19 Sep 2005 15:01:20 -0700 (PDT)
From: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
Subject: Re: Help by KConfig expansion
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050919170620.GA7720@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Sam Ravnborg <sam@ravnborg.org> wrote:

> > I tryed to do this. I saw how the attribute
> "comment"
> > is definded in the zconf.l and zconf.y, and
> definded
> > the the attribute "autorule" exactly the same way.
> But
> > it still don't work. Even though I changed the
> > zconf.tab.c_shipped as well but it still dont
> work.
> 
> You need to generate the source using bison.
> You must understand that zconf.l is an input file
> for flex.
> Likewise zconf.y is input for bison.
> 
> See scripts/kconfig/Makefile for how to generate the
> files.
> 

It works. Thanks you very much. 

Regards

A.R.Cheraghi


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
