Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWFNQqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWFNQqT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 12:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWFNQqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 12:46:19 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:27294 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750854AbWFNQqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 12:46:18 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
To: grundig <grundig@teleline.es>, jeff@garzik.org, alex@clusterfs.com,
       alan@lxorguk.ukuu.org.uk, chase.venters@clientec.com, torvalds@osdl.org,
       adilger@clusterfs.com, akpm@osdl.org, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Wed, 14 Jun 2006 18:45:31 +0200
References: <6lDZ6-6Hg-11@gated-at.bofh.it> <6lFet-8vZ-1@gated-at.bofh.it> <6lKHf-84q-19@gated-at.bofh.it> <6lQMJ-sm-13@gated-at.bofh.it> <6lR6f-Rx-33@gated-at.bofh.it> <6lRpH-1h2-51@gated-at.bofh.it> <6lRIT-1T1-23@gated-at.bofh.it> <6lS26-2ho-7@gated-at.bofh.it> <6lSvd-2Sh-15@gated-at.bofh.it> <6lTKz-4Ru-9@gated-at.bofh.it> <6lTUf-54A-17@gated-at.bofh.it> <6lU3S-5h5-11@gated-at.bofh.it> <6lU3X-5h5-35@gated-at.bofh.it> <6lUnl-5GL-5@gated-at.bofh.it> <6lUwX-66U-25@gated-at.bofh.it> <6lUQo-6w3-29@gated-at.bofh.it> <6lUQp-6w3-35@gated-at.bofh.it> <6lUZT-6HS-3@gated-at.bofh.it> <6nE4Z-4If-55@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1FqYV5-00047Z-A6@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

grundig <grundig@teleline.es> wrote:
> Alex Tomas <alex@clusterfs.com> escribió:

>> that's your point of view. mine is that this option (and code)
>> to be used only when needed.
> 
> Distros may ignore your opinion and may enable it, and users won't know
> that it's enabled or even if such feature exist - until they try to run
> an older kernel. If almost nobody needs this feature, why not avoid
> problems by not merging it and maintaining it separated from the
> main tree?

Distros might patch their kernel to support this feature and enable it,
therefore you MUST NOT release new features AT ALL!!!1 - NOT

If a distro decides to enable a non-backward-compatible feature without
warning, it's their fault.

BTW: Upgrading a filesystem by using mount options _and_ forcing that
option to be supplied on subsequent mounts is a BUG. If should be what
current code demands, it should be fixed ASAP. I hope that's not what
the current code does.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
