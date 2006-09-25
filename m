Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWIYIxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWIYIxI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 04:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWIYIxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 04:53:07 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:26826 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S1750752AbWIYIxG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 04:53:06 -0400
Subject: Re: [PATCH] aoa is pmac-only
From: Johannes Berg <johannes@sipsolutions.net>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060923002425.GY29920@ftp.linux.org.uk>
References: <20060923002425.GY29920@ftp.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Sep 2006 10:53:25 +0200
Message-Id: <1159174405.4509.8.camel@ux156>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92 
X-sips-origin: local
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-23 at 01:24 +0100, Al Viro wrote:

>  menu "Apple Onboard Audio driver"
> -	depends on SND!=n && PPC
> +	depends on SND!=n && PPC_PMAC

Oh, that's right.

Acked-by: Johannes Berg <johannes@sipsolutions.net>

johannes
