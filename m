Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWD0AZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWD0AZg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 20:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWD0AZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 20:25:36 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:9209 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751321AbWD0AZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 20:25:35 -0400
Date: Wed, 26 Apr 2006 20:25:33 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: can't compile kernels lately (2.6.16.5 and up)
In-reply-to: <2f4958ff0604260817l68235c77hb3430b2a800a96cf@mail.gmail.com>
To: linux-kernel@vger.kernel.org
Message-id: <200604262025.33796.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: 8BIT
Content-disposition: inline
References: <2f4958ff0604260639n4874c2aua1e99ec4c32d2182@mail.gmail.com>
 <200604261102.12935.gene.heskett@verizon.net>
 <2f4958ff0604260817l68235c77hb3430b2a800a96cf@mail.gmail.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 April 2006 11:17, Grzegorz Jaśkiewicz wrote:
>don't think that's the issue man. I got 2.6.16.5 from tar.bz2, than
>just upgraded with patches to 2.6.16.9, where it stopped to compile.
>Now with 2.6.16.11 it still doens't work

I'm now booted to 2.6.16.11, and here, from my buildit script, is the 
list of patches used, most of them simply saved to /usr/src from this 
list:
VEROLD="linux-2.6.16.9"
# This is the src file to be used
VERSRC="linux-2.6.16"
# These are the patchfile(s) to be used
VERP1="../patch-2.6.16.3"
VERP2="../patch-2.6.16.3-2.6.16.4"
VERP3="../patch-2.6.16.5"
VERP4="../patch-2.6.16.6"
VERP5="../patch-2.6.16.7"
VERP6="../patch-2.6.16.8"
VERP7="../patch-2.6.16.9"
VERP8="../patch-2.6.16.10"
VERP9="../patch-2.6.16.11"

They are applied in the above sequence further down in the script, and 
they are all error free in application, and now in running that kernel 
too.
[root@coyote src]# uname -r
2.6.16.11

Anyplace you are using a bz2, replace it with the .gz version and see if 
you still have the problem.  I'm not betting one way or the other, but 
it sure tastes like it to me.

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
