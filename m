Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932759AbWFVD5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932759AbWFVD5F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 23:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932763AbWFVD5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 23:57:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24256 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932759AbWFVD5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 23:57:01 -0400
Date: Wed, 21 Jun 2006 20:56:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alasdair G Kergon <agk@redhat.com>
Cc: linux-kernel@vger.kernel.org, mbroz@redhat.com
Subject: Re: [PATCH 03/15] dm mpath: support ioctls
Message-Id: <20060621205643.3da38986.akpm@osdl.org>
In-Reply-To: <20060621193333.GR4521@agk.surrey.redhat.com>
References: <20060621193333.GR4521@agk.surrey.redhat.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 20:33:33 +0100
Alasdair G Kergon <agk@redhat.com> wrote:

> +	return r ? : blkdev_ioctl(bdev->bd_inode, filp, cmd, arg);

Ditto.
