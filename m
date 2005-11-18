Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161083AbVKRM35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161083AbVKRM35 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 07:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161084AbVKRM35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 07:29:57 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:49612 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S1161083AbVKRM34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 07:29:56 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: Does Linux has File Stream mapping support...?
To: Arijit Das <Arijit.Das@synopsys.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Fri, 18 Nov 2005 13:30:17 +0100
References: <5abPs-7Da-41@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1Ed5Nn-0000Zm-2q@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arijit Das <Arijit.Das@synopsys.com> wrote:

> Is it possible to have File Stream Mapping in Linux? What I mean is
> this...
> 
> FILE * fp1 = fopen("/foo", "w");
> FILE * fp2 = fopen("/bar", "w");
> FILE * fp_common = <Stream_Mapping_Func>(fp1, fp2);
> 
> fprint(fp_common, "This should be written to both files ... /foo and
> /bar");

It's a userspace problem. man "tee".

Doing this in the kernel would be horrible.

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
