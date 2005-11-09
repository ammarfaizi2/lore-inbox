Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161265AbVKIWEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161265AbVKIWEP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161277AbVKIWEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:04:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3539 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161281AbVKIWEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:04:12 -0500
Date: Wed, 9 Nov 2005 14:03:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, karim@opersys.com
Subject: Re: [PATCH 4/4] relayfs: Documentation for exported relay fileops
Message-Id: <20051109140336.2d584067.akpm@osdl.org>
In-Reply-To: <17266.28537.722390.913812@tut.ibm.com>
References: <17266.28537.722390.913812@tut.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Zanussi <zanussi@us.ibm.com> wrote:
>
> +By default of course, relay_open() creates relay files in the relayfs
>  +filesystem.  Because relay_file_operations is exported, however, it's
>  +also possible to create and use relay files in other pseudo-filesytems
>  +such as debugfs.

Why would anyone wish to place relayfs files within other filesystems?

If users wish relayfs files to appear in other places, is it not sufficient
to do this with mount tricks?
