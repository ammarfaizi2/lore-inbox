Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUAMSWk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 13:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264903AbUAMSWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 13:22:13 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:30693 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265114AbUAMSVT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 13:21:19 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Benecke <jens@spamfreemail.de>
Subject: Re: 2.6.1mm2: nforce2 / amd74xx IDE driver doesn't load
Date: Tue, 13 Jan 2004 19:24:51 +0100
User-Agent: KMail/1.5.4
References: <2867040.OKCKYgd4AF@spamfreemail.de> <200401131756.03852.bzolnier@elka.pw.edu.pl> <bu1ccg$ouh$1@sea.gmane.org>
In-Reply-To: <bu1ccg$ouh$1@sea.gmane.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401131924.51778.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 of January 2004 19:11, Jens Benecke wrote:

> PS: this worked in 2.4 (loading the IDE driver later as module, but booting
> from IDE as well), why doesn't it work in 2.6 any more?

Because 2.6.x is different (most host drivers probe for drives themselves)
and nobody fixed this issue :-).

--bart

