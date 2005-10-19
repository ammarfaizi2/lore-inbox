Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbVJSBmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbVJSBmG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 21:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbVJSBmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 21:42:05 -0400
Received: from quechua.inka.de ([193.197.184.2]:50862 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S932092AbVJSBmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 21:42:03 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: large files unnecessary trashing filesystem cache?
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <1e62d1370510181733n131a4465j36531064551ef478@mail.gmail.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1ES2xt-00036s-00@calista.inka.de>
Date: Wed, 19 Oct 2005 03:42:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1e62d1370510181733n131a4465j36531064551ef478@mail.gmail.com> you wrote:
> Is I m correct ??? or missing something ??

Well, applications who know the file is not going to be cached should
clearly give that hint. someheuristics in detecting "streaming one time"
access is usefull, however a more strict limitation on process level would
make the system more sane and stop single files from occupying most of the block
buffer.

Gruss
Bernd
y
