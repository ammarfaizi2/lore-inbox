Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262742AbULQEJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbULQEJN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 23:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262748AbULQEJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 23:09:05 -0500
Received: from hera.kernel.org ([209.128.68.125]:42732 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262740AbULQEGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 23:06:46 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: debugfs in the namespace
Date: Fri, 17 Dec 2004 04:06:00 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cptlv8$9kd$1@terminus.zytor.com>
References: <20041216110002.3e0ddf52@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1103256360 9870 127.0.0.1 (17 Dec 2004 04:06:00 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 17 Dec 2004 04:06:00 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20041216110002.3e0ddf52@lembas.zaitcev.lan>
By author:    Pete Zaitcev <zaitcev@redhat.com>
In newsgroup: linux.dev.kernel
>
> Hi Greg,
> 
> what is the canonic place to mount debugfs: /debug, /debugfs, or anything
> else? The reason I'm asking is that USBMon has to find it somewhere and
> I'd really hate to see it varying from distro to distro.
> 
> Thanks,
> -- Pete
> 

/dev is the normal place where stuff related to the user/kernel
interface should go, so /dev/debug or /dev/debugfs would be the right
answer (and yes, /proc and /sys violate this, but we're stuck with
those.)

	-hpa
