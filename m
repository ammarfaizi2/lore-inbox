Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265073AbUF1XZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265073AbUF1XZi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 19:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265288AbUF1XZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 19:25:38 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:58323 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265073AbUF1XZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 19:25:37 -0400
From: Patrick Dreker <patrick@dreker.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE Timeout problem on Intel PIIX3 (Triton 2) chipset
Date: Tue, 29 Jun 2004 01:25:08 +0200
User-Agent: KMail/1.6.2
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
References: <200406281448.15725.patrick@dreker.de> <200406282221.48896.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200406282221.48896.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406290125.09325.patrick@dreker.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:55d40479e9cc6e4ab087ddd2b9b4bce4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 28. Juni 2004 22:21 schrieb Bartlomiej Zolnierkiewicz:
> On Monday 28 of June 2004 14:48, Patrick Dreker wrote:

> > What can I do to debug this problem?
> "diff -u" on "lspci -s 07.1 -xxx" outputs for 2.4.20 and 2.4.21 kernels.
>
> Doing bisection search on 2.4.21-pre kernels would also help.
I will do the bisection search first and then post the lspci diff between the 
last working revision and the first non-working version as I have to 
recompile everything anyways.

Thanks,
Patrick
-- 
Patrick Dreker

GPG KeyID  : 0xFCC2F7A7 (Patrick Dreker)
Fingerprint: 7A21 FC7F 707A C498 F370  1008 7044 66DA FCC2 F7A7
Key available from keyservers
