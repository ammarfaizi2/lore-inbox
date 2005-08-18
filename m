Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbVHRGXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbVHRGXt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 02:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbVHRGXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 02:23:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24200 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750838AbVHRGXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 02:23:48 -0400
Date: Wed, 17 Aug 2005 23:22:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-cluster@redhat.com,
       Mark Fasheh <mark.fasheh@oracle.com>
Subject: Re: [PATCH 1/3] dlm: use configfs
Message-Id: <20050817232218.56a06fd6.akpm@osdl.org>
In-Reply-To: <20050818060750.GA10133@redhat.com>
References: <20050818060750.GA10133@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Teigland <teigland@redhat.com> wrote:
>
> Use configfs to configure lockspace members and node addresses.  This was
>  previously done with sysfs and ioctl.

Fair enough.  This really means that the configfs patch should be split out
of the ocfs2 megapatch...
