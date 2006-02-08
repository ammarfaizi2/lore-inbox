Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWBHUyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWBHUyo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 15:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWBHUyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 15:54:44 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:5248 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751117AbWBHUyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 15:54:43 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: Question regarding /proc/<pid>/fd and pipes
To: John Schmerge <schmerge@speakeasy.net>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Wed, 08 Feb 2006 15:45:24 +0100
References: <5DRW7-322-1@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1F6qZR-0002uc-Kc@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Schmerge <schmerge@speakeasy.net> wrote:

>   I know that the symlinks in the /proc/<pid>/fd directory point to
> bogus filenames for pipes (i.e. 'pipe:[64682]') and am wondering if
> every process that reads and writes from that pipe will share the same
> bogus symlink name.

yes

>   In essence, I'm wondering if there's any way to list all of the pid's
> of processes using an anonomous pipe.

man find. I don't know a bettre way.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
