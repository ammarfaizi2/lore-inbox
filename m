Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268970AbUHZOUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268970AbUHZOUm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 10:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268963AbUHZORT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 10:17:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23965 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268966AbUHZOOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 10:14:52 -0400
Date: Thu, 26 Aug 2004 10:12:53 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, <wichert@wiggy.net>, <jra@samba.org>,
       <torvalds@osdl.org>, <reiser@namesys.com>, <hch@lst.de>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <flx@namesys.com>, <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <200408261700.43253.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.44.0408261011410.27909-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004, Denis Vlasenko wrote:

> I think Hans is not planning turning old "file is a stream of bytes"
> into eight-stream octopus. One stream will remain as a 'main' one,
> which contains actual data. Others will keep metadata, etc...

This is exactly what the Samba people want, though. 

Office suites can store a document with embedded images
and spread sheets "easily" by putting the text, the
images and spread sheets all in different file streams.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

