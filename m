Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268981AbUIADZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268981AbUIADZq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 23:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268983AbUIADZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 23:25:46 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:20704 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268981AbUIADZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 23:25:45 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: chiwq@yahoo.com
Subject: Re: How to run 2.6.8.1 on Tiger 4
Date: Tue, 31 Aug 2004 20:25:41 -0700
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20040901020454.68801.qmail@web52502.mail.yahoo.com>
In-Reply-To: <20040901020454.68801.qmail@web52502.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408312025.41931.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 31, 2004 7:04 pm, chiwq@yahoo.com wrote:
> I can run 2.6.0 with ia64 ports on Tiger 4,
> bun can not run 2.6.4 with ia64 ports on it ,
> and can not run 2.6.8.1 on Tiger 4.
>
> How to do?

You could buy an Altix, which works fine.  :)  Or you could try to configure a 
kernel with arch/ia64/configs/generic_defconfig, e.g.:

  # tar zxf linux-2.6.8.1.tar.gz
  # cd linux-2.6.8.1
  # make generic_defconfig
  # make compressed
  # cp vmlinux.gz /boot/efi
  <boot it>

If that doesn't work, please describe what happens in more detail.

Jesse
