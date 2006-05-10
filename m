Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbWEJSlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWEJSlZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 14:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWEJSlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 14:41:25 -0400
Received: from mx.pathscale.com ([64.160.42.68]:19855 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932458AbWEJSlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 14:41:25 -0400
Subject: Re: [openib-general] Openmpi/xhpl kernel crash 2.6.17-rc3 with
	Pathscale htx
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roger Heflin <rheflin@atipa.com>
Cc: openib-general@openib.org, Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <445FB9C7.8060507@atipa.com>
References: <445FB9C7.8060507@atipa.com>
Content-Type: text/plain
Date: Wed, 10 May 2006 11:41:31 -0700
Message-Id: <1147286491.22656.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-08 at 16:36 -0500, Roger Heflin wrote:

> I don't see the crash under ip over ib (ran for over an hour),
> the crash occurs immediately upon attempting to start xhpl.

Hi, Roger -

Thanks for the report.  We've recently fixed some locking problems that
may help with this, but I haven't fed them to Roland yet.  If you need
some updated code to test before I sort out and send patches to Roland,
please let me know.

Thanks,

	<b

