Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269044AbUHZP2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269044AbUHZP2r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 11:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269052AbUHZP2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 11:28:47 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:9478 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S269044AbUHZP1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 11:27:46 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Rik van Riel <riel@redhat.com>
Subject: Re: silent semantic changes with reiser4
Date: Thu, 26 Aug 2004 18:19:59 +0300
User-Agent: KMail/1.5.4
Cc: Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, <wichert@wiggy.net>, <jra@samba.org>,
       <torvalds@osdl.org>, <reiser@namesys.com>, <hch@lst.de>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <flx@namesys.com>, <reiserfs-list@namesys.com>
References: <Pine.LNX.4.44.0408261011410.27909-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0408261011410.27909-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408261819.59328.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 August 2004 17:12, Rik van Riel wrote:
> On Thu, 26 Aug 2004, Denis Vlasenko wrote:
> > I think Hans is not planning turning old "file is a stream of bytes"
> > into eight-stream octopus. One stream will remain as a 'main' one,
> > which contains actual data. Others will keep metadata, etc...
>
> This is exactly what the Samba people want, though.
>
> Office suites can store a document with embedded images
> and spread sheets "easily" by putting the text, the
> images and spread sheets all in different file streams.

Kinda far reaching. It's hard to assess whether that is good or bad idea.
Can we start small, like putting metadata (e.g. ACLs) into these streams?
--
vda

