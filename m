Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbVJDVU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbVJDVU3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 17:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbVJDVU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 17:20:29 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:22956 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S964982AbVJDVU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 17:20:28 -0400
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: /etc/mtab and per-process namespaces
To: Al Viro <viro@ftp.linux.org.uk>, David Leimbach <leimy2k@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Tue, 04 Oct 2005 23:20:12 +0200
References: <4TkbZ-6KJ-9@gated-at.bofh.it> <4U0uy-33E-7@gated-at.bofh.it> <4U0XK-3Gp-47@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EMuCq-0000yq-Dt@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> wrote:

> 4) If you insist on having /etc/mtab the same file in all namespaces,
> you obviously will have its contents not matching at least some
> of them.  Either have it separate in each namespace where you want
> to see it, or simply use /proc/self/mounts instead.

So /proc/mounts should be a symlink to /proc/self/mounts?

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
