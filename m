Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265900AbUJEU4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbUJEU4M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 16:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265970AbUJEU4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 16:56:12 -0400
Received: from h66-38-154-67.gtcust.grouptelecom.net ([66.38.154.67]:444 "EHLO
	pbl.ca") by vger.kernel.org with ESMTP id S265900AbUJEU4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 16:56:07 -0400
Message-ID: <41630B6D.3050109@pbl.ca>
Date: Tue, 05 Oct 2004 16:00:29 -0500
From: Aleksandar Milivojevic <amilivojevic@pbl.ca>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.5-1.358 and Fedora
References: <1097004565.9975.25.camel@laptop.fenrus.com> <Pine.LNX.4.61.0410052140150.2913@dragon.hygekrogen.localhost> <Pine.LNX.4.53.0410051635370.3240@quark.analogic.com>
In-Reply-To: <Pine.LNX.4.53.0410051635370.3240@quark.analogic.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johnson, Richard wrote:
> Yeh?  There is no place to get replacement modules from. They are
> somewhere on some RPM on one of the CDs, with no way to know. It's
> not like you could tar everything from the current root file-system.
> 
> They don't exist in the root file-system, which is a RAM disk.

RPM is called kernel (suprise), it's on the first CD (logical).

Boot from CD into rescue mode, and than:

# chroot /mnt/sysimage (if not done for you by rescue)
# rpm -q -f /lib/modules/2.6.5-1.358
kernel-2.6.5-1.358
# uname -c
i686
# rpm -Uhv --force /mnt/cdrom/Fedora/RPMS/kernel-2.6.5-1.358.i686.rpm

-- 
Aleksandar Milivojevic <amilivojevic@pbl.ca>    Pollard Banknote Limited
Systems Administrator                           1499 Buffalo Place
Tel: (204) 474-2323 ext 276                     Winnipeg, MB  R3T 1L7
