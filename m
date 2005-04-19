Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVDSUbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVDSUbc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 16:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVDSUbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 16:31:32 -0400
Received: from pat.uio.no ([129.240.130.16]:2271 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261260AbVDSUba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 16:31:30 -0400
Date: Tue, 19 Apr 2005 22:31:26 +0200 (CEST)
From: =?iso-8859-1?Q?P=E5l_Halvorsen?= <paalh@ifi.uio.no>
To: linux-kernel@vger.kernel.org
Subject: getrusage
Message-ID: <Pine.LNX.4.62.0504192225470.4538@nelja.ifi.uio.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-UiO-Spam-info: not spam, SpamAssassin (score=-6.941, required 12,
	autolearn=disabled, ALL_TRUSTED -2.82, AWL 0.88,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

Is getrusage properly implemented in 2.6?

The man pages state:

   Right  now  (Linux  2.4,  2.6)  only  the  fields
   ru_utime,  ru_stime, ru_minflt, ru_majflt, and ru_nswap are maintained.

but some tests comparing UDP and TCP sending operations give some strange 
numbers for both the user and kernel times!?

PS! Does Linux 2.6 support zero-copy TCP send?

Thank you.

-ph
