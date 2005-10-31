Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbVJaQnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbVJaQnx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 11:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVJaQnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 11:43:53 -0500
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:48340 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S932465AbVJaQnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 11:43:52 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [BUG 2579] linux 2.6.* sound problems
To: patrizio.bassi@gmail.com, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Mon, 31 Oct 2005 17:43:37 +0100
References: <53JVy-4yi-19@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EWcl3-0001cd-2b@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrizio Bassi <patrizio.bassi@gmail.com> wrote:
> starting from 2.6.0 (2 years ago) i have the following bug.

> link: http://bugzilla.kernel.org/show_bug.cgi?id=2579
> and https://bugtrack.alsa-project.org/alsa-bug/view.php?id=230
> 
> fast summary:
> when playing audio and using a bit the harddisk (i.e. md5sum of a 200mb
> file)
> i hear noises, related to disk activity. more hd is used, more chicks
> and ZZZZ noises happen.

Maybe you just need to tune down unused and non-connected inputs in the
mixer, especially microphone? Happened to me once.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
