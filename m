Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266995AbUBRWoF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 17:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266927AbUBRWoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 17:44:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:40399 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266995AbUBRWnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 17:43:55 -0500
Date: Wed, 18 Feb 2004 14:43:46 -0800
From: Chris Wright <chrisw@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: "David S. Miller" <davem@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil, selinux@tycho.nsa.gov
Subject: Re: [SELINUX] Event notifications via Netlink
Message-ID: <20040218144346.B22989@build.pdx.osdl.net>
References: <20040218125545.6c499296.davem@redhat.com> <Xine.LNX.4.44.0402181621390.28705-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Xine.LNX.4.44.0402181621390.28705-100000@thoron.boston.redhat.com>; from jmorris@redhat.com on Wed, Feb 18, 2004 at 04:22:51PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Morris (jmorris@redhat.com) wrote:
> +static int selnl_msglen(int msgtype)
> +	default:
> +		BUG();
> +static void selnl_add_payload(struct nlmsghdr *nlh, int len, int msgtype, void *data)
> +	default:
> +		BUG();

Is BUG() the best error here, or too draconian?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
