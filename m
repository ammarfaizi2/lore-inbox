Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262556AbUJ0R32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbUJ0R32 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 13:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbUJ0R0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 13:26:33 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:61844 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262548AbUJ0RSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 13:18:22 -0400
Date: Wed, 27 Oct 2004 19:17:48 +0200
From: kladit@t-online.de (Klaus Dittrich)
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] 2.6.10.rc1.bk6 /lib/kobject_uevent.c buffer issues
Message-ID: <20041027171748.GA23243@xeon2.local.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ID: X7RAUOZcoevJiMd+iggZLkfdAe8Ii1YlKZHGqxz+d0xgHSn8hHFI6S
X-TOI-MSGID: 55dc6b3d-4cf2-4a8c-92aa-5f88add7959e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What speaks against allocating the buffer in kset_hotplug_ops.hotplug()
and adding the env variables later in a more consistent way by calls to
add_hotplug_env_var()?

-- 
Klaus
