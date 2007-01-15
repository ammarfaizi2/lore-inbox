Return-Path: <linux-kernel-owner+w=401wt.eu-S1750741AbXAOREN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbXAOREN (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 12:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbXAOREM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 12:04:12 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:39267 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbXAOREM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 12:04:12 -0500
Date: Mon, 15 Jan 2007 18:04:12 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Andrew Walrond <andrew@walrond.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Initramfs and /sbin/hotplug fun
Message-ID: <20070115170412.GA26414@aepfle.de>
References: <45AB8CB9.2000209@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <45AB8CB9.2000209@walrond.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, Andrew Walrond wrote:

> To solve this, I deleted /sbin/hotplug from the initramfs archive and 
> modified /init to reinstate it once it gets control. This works fine, 
> but seems inelegant. Is there a better solution? Should sbin/hotplug be 
> called at all before the kernel has passed control to /init?

Yes, it should be called.
/sbin/hotplug and /init are two very different and unrelated things.

