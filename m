Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbUJYSoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbUJYSoh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 14:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbUJYSm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 14:42:59 -0400
Received: from aurisp.biz ([81.169.158.23]:3518 "EHLO mail.aurisp.de")
	by vger.kernel.org with ESMTP id S261160AbUJYSmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 14:42:01 -0400
Message-ID: <417D4907.9000500@ng.h42.net>
Date: Mon, 25 Oct 2004 20:42:15 +0200
From: Lars Ehrhardt <1004@ng.h42.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9: umount problem at shutdown (2.6.7-bk20 was ok) 
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have experienced something similiar today. I was trying to resize a 
logical volume on a lvm2 volume group. However, doing the needed umount 
also returned "device busy". "lsof" did not list any open files on that 
partition.

Kernel is 2.6.9-ac3 on Debian Testing.

Cheers,
Lars
