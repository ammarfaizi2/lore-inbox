Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVCAAwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVCAAwI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 19:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbVCAAsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 19:48:00 -0500
Received: from pop.gmx.net ([213.165.64.20]:62615 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261168AbVCAAn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 19:43:28 -0500
X-Authenticated: #26200865
Message-ID: <4223BB3B.4060309@gmx.net>
Date: Tue, 01 Mar 2005 01:45:47 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040906
X-Accept-Language: de, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: updating mtime for char/block devices?
References: <42225CEE.1030104@gmx.net> <1109576878.6298.49.camel@laptopd505.fenrus.org>
In-Reply-To: <1109576878.6298.49.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven schrieb:
> On Mon, 2005-02-28 at 00:51 +0100, Carl-Daniel Hailfinger wrote:
> 
>>Hi,
>>
>>is it intentional that
>>echo foo >/dev/hda1
>>doesn't update the mtime of the device node, but
>>echo foo >/dev/tty10
>>does update the mtime of the device node?
>>
>>And no, mounting with the noatime flag doesn't help because the
>>mtime is updated. IIRC some time ago this behaviour was different,
>>but I could easily be mistaken.
> 
> 
> devices are tricky in general in this respect, /dev may be mounted read
> only for example ;)

Sorry for not specifying my real problem which is preventing disk access
when my laptop is running on battery.

Can I prevent mtime updates for all device files? Mounting /dev readonly
would certainly help, but for that to work I'd have to move /dev to a
different filesystem, right?


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
