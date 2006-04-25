Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWDYPtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWDYPtm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 11:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWDYPtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 11:49:42 -0400
Received: from xenotime.net ([66.160.160.81]:17899 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751322AbWDYPtm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 11:49:42 -0400
Date: Tue, 25 Apr 2006 08:52:07 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] [doc] add paragraph about 'fs' subsystem to
 sysfs.txt
Message-Id: <20060425085207.be08fb19.rdunlap@xenotime.net>
In-Reply-To: <E1FYJ6B-0006Va-00@dorka.pomaz.szeredi.hu>
References: <E1FYJ0r-0006Tv-00@dorka.pomaz.szeredi.hu>
	<E1FYJ6B-0006Va-00@dorka.pomaz.szeredi.hu>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2006 10:40:43 +0200 Miklos Szeredi wrote:

> diff --git a/Documentation/filesystems/sysfs.txt b/Documentation/filesystems/sysfs.txt
> index c8bce82..1b3a952 100644
> --- a/Documentation/filesystems/sysfs.txt
> +++ b/Documentation/filesystems/sysfs.txt
> @@ -246,6 +246,7 @@ class/
>  devices/
>  firmware/
>  net/
> +fs/
>  
>  devices/ contains a filesystem representation of the device tree. It maps
>  directly to the internal kernel device tree, which is a hierarchy of
> @@ -264,6 +265,10 @@ drivers/ contains a directory for each d
>  for devices on that particular bus (this assumes that drivers do not
>  span multiple bus types).
>  
> +fs/ contains a directory for some filesystems.  Currently each
> +filesystem wanting to export attributes must create it's own hierarchy
> +below fs/ (see ./fuse.txt for an example).

s/it's/its/
"it's" == "it is", which wouldn't be appropriate here.

---
~Randy
