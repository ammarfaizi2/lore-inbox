Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262199AbVFRTKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262199AbVFRTKE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 15:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbVFRTKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 15:10:04 -0400
Received: from quechua.inka.de ([193.197.184.2]:19361 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262199AbVFRTJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 15:09:59 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <200506181804.21366.robin.rosenberg.lists@dewire.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1DjihY-0007JB-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sat, 18 Jun 2005 21:09:56 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200506181804.21366.robin.rosenberg.lists@dewire.com> you wrote:
> Every unicode character has exactly one  UTF-8 representation. 

Every unicode code point has exactly one UTF-8 representation, however there
are for a few glyphs multiple code points. And this is not only a problem
beause of homoglphys which look like/similiar, but also because of combining
characters vs. legacy characters. However thats more an issue of the user
interface (think IDN exploits).

Personally I think the on-disk  filesystem format should be required to be
UTF-8, and its an open discussion if the syscalls accept UTF-8 or locale
byte encodings. Currently its a mess. We can learn from Windows here:)

Greetings
Bernd
