Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbTJTMLb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 08:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262555AbTJTMLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 08:11:31 -0400
Received: from mx2.seznam.cz ([212.80.76.42]:56011 "HELO email.seznam.cz")
	by vger.kernel.org with SMTP id S262554AbTJTMLb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 08:11:31 -0400
From: =?us-ascii?Q?Pavel=20Krauz?= <Pavel.Krauz@seznam.cz>
To: linux-kernel@vger.kernel.org
Subject: =?us-ascii?Q?READ=2DONLY=20mmap=20not=20present=20in=20core?=
Date: Mon, 20 Oct 2003 14:11:26 +0200 (CEST)
Content-Type: text/plain;
	charset="iso-8859-2"
Message-Id: <79944.195572-26028-2050931566-1066651886@seznam.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Reply-To: =?us-ascii?Q?Pavel=20Krauz?= <Pavel.Krauz@seznam.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have verified that the READ_ONLY mmap mapping of file did not propagate 
to core file. For instance, if you share some file through which you exchange data
from one process to the other, you won't see it in debugger after the crash.
Is that known limitation? Can it be fixed?

best regards
Pavel

____________________________________________________________
Jak zjistit historii ojetého vozu? http://ad2.seznam.cz/redir.cgi?instance=62697%26url=http://www.auto-plus.cz/faq.php
