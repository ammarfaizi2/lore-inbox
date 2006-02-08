Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965064AbWBHNXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbWBHNXg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 08:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbWBHNXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 08:23:36 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:44968 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S965064AbWBHNXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 08:23:35 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
To: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Nigel Cunningham <nigel@suspend2.net>,
       Lee Revell <rlrevell@joe-job.com>,
       Jim Crilly <jim@why.dont.jablowme.net>,
       suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Wed, 08 Feb 2006 14:23:18 +0100
References: <5BoER-4GL-3@gated-at.bofh.it> <5DJOW-7ll-9@gated-at.bofh.it> <5DK8h-7YA-13@gated-at.bofh.it> <5DKrG-8nS-13@gated-at.bofh.it> <5DKUI-1Dm-21@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1F6pHz-0000kU-FN@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are some questions I have while looking at this HOWTO,
which I think should be answered there:

Pavel Machek <pavel@ucw.cz> wrote:

> Suspend-to-disk HOWTO
> ~~~~~~~~~~~~~~~~~~~~
[...]
> ./suspend /dev/<your_swap_partition>

Does it need to be mounted (so it possibly gets filled and thereby unusable),
or can it be a mkswapped partition?

Can it even be a swap-file? Probably not, unless you want to resume by
ro-nojournalreplay-mounting the corresponding partition.

How big does it have to be, compared to the RAM? As big + n? Bigger? BIGGER?
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
