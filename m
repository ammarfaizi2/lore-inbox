Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVIJQCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVIJQCF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 12:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbVIJQCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 12:02:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56290 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750813AbVIJQCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 12:02:03 -0400
Date: Sat, 10 Sep 2005 09:01:52 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Karel Kulhavy <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: USB digital camera erroneously says "no medium found"
Message-Id: <20050910090152.3d956e18.zaitcev@redhat.com>
In-Reply-To: <mailman.1126259764.18971.linux-kernel2news@redhat.com>
References: <mailman.1126259764.18971.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sep 2005 11:15:02 +0200, Karel Kulhavy <clock@twibright.com> wrote:

> [...] When compact flash is inside the camera,
> camera turned on and connected, cat /dev/sda says no media found.

There's no way it could happen after this:

> sda: assuming drive cache: write through
>  sda: sda1

You simply did something wrong when experimenting with this.

On second thought, getting a trace with CONFIG_USB_STORAGE_DEBUG would
probably be helpful.

BTW, does ub work (CONFIG_BLK_DEV_UB)?

-- Pete
