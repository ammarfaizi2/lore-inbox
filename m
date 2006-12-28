Return-Path: <linux-kernel-owner+w=401wt.eu-S1754883AbWL1Pm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754883AbWL1Pm7 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 10:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754879AbWL1Pm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 10:42:59 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:30967 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883AbWL1Pm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 10:42:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pcFgca5XW8h4yOd0Yq0FBVUiv1xpz/ejQQrPIB9rgWrQI285Ry2W6ny7gdhVhKEkrwsyC2I/4DP0uCycuvNkK+wg0U6A+0/ZBYO0PVmooKr+jbMqypx3kJQOjGIk0JLCKl4NFBRIikArNzzTh6wXsc+KaaI+3PKGxCILOL2OUfA=
Message-ID: <b6a2187b0612280742x1b613849ye23aca38c71a5871@mail.gmail.com>
Date: Thu, 28 Dec 2006 23:42:51 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: "Avi Kivity" <avi@argo.co.il>
Subject: Re: open /dev/kvm: No such file or directory
Cc: "Dor Laor" <dor.laor@qumranet.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4593D9F5.6010807@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b6a2187b0612280508t24e0a740nd1aabdfeb706fbec@mail.gmail.com>
	 <64F9B87B6B770947A9F8391472E0321609AB0D35@ehost011-8.exch011.intermedia.net>
	 <b6a2187b0612280638o3d7c48ecn13b5dece8395b41a@mail.gmail.com>
	 <4593D9F5.6010807@argo.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/06, Avi Kivity <avi@argo.co.il> wrote:

> udev is the best solution here.  It works with read-only root as it
> mounts tmpfs on /dev.

Thanks for the suggestion and I'll look into it. As for now, my system
works well without udev, and I just wanted to test kvm without the
"dynamic" /dev/kvm feature if possible.

Would it be possible to create /dev/kvm once and let it stay there
permanently? How about a switch for non-udev system?

Thanks,
Jeff.
