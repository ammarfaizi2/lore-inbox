Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266786AbUITQO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266786AbUITQO7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 12:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266793AbUITQO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 12:14:58 -0400
Received: from host50.200-117-131.telecom.net.ar ([200.117.131.50]:55981 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S266786AbUITQO5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 12:14:57 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: FIXED (Is anyone using vmware 4.5 with 2.6.9-rc2-mm1?)
Date: Mon, 20 Sep 2004 13:14:46 -0300
User-Agent: KMail/1.7
Cc: nhorman@redhat.com, Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
References: <200409191214.47206.norberto+linux-kernel@bensa.ath.cx> <414EBA3A.6010205@redhat.com> <200409201024.26912.norberto+linux-kernel@bensa.ath.cx>
In-Reply-To: <200409201024.26912.norberto+linux-kernel@bensa.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409201314.46766.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norberto Bensa wrote:
> And the message that vmware shows in a dialog box:
>   Could not mmap 139264 bytes of memory from file offset 0 at
>   (nil): Operation not permitted.
>   Failed to allocate shared memory.

It's working now. I had this in fstab:

tmpfs    /dev/shm   tmpfs    size=2m,noexec,nosuid,nodev     0 0
                             ^^^^^^^

I removed "size=2m" and a remount fixed vmware.


Thanks everyone!!

Regards,
Norberto
