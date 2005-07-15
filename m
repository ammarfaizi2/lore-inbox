Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVGQLIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVGQLIw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 07:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVGQLIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 07:08:52 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:53966 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S261246AbVGQLIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 07:08:51 -0400
From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
Subject: Re: [PATCH] ramfs: pretend dirent sizes
To: Jan Blunck <j.blunck@tu-harburg.de>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Fri, 15 Jul 2005 15:12:58 +0200
References: <4qoKs-6yv-13@gated-at.bofh.it> <4qoU5-6CQ-3@gated-at.bofh.it> <4qvsI-32Y-17@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1DtPzv-0002aA-8l@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Blunck <j.blunck@tu-harburg.de> wrote:
> Andrew Morton wrote:

>  > Does it really matter?
>  >
> 
> Yes! At least for me and my union mounts implementation.

Is there a reason for not using size == link-count (or even static)?
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
