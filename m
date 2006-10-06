Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWJFLpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWJFLpj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 07:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161004AbWJFLpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 07:45:38 -0400
Received: from main.gmane.org ([80.91.229.2]:41642 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750860AbWJFLpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 07:45:38 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [PATCH 01/02] net/ipv6: seperate sit driver to extra module
Date: 06 Oct 2006 13:38:24 +0200
Message-ID: <87d595lln3.fsf@willow.rfc1149.net>
References: <20061006093402.GA12460@zlug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: zaphod.rfc1149.net
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
X-Leafnode-NNTP-Posting-Host: 2001:6f8:37a:2::2
Cc: netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Joerg" == Joerg Roedel <joro-lkml@zlug.org> writes:

Joerg> this is the submit of the patch discussed yesterday to compile
Joerg> the sit driver as a seperate module.

Your patch looks ok to me, but given that many people won't need sit,
why is it enabled by default? Omitting it would save 10k of kernel
text on x86 and people will see the new kernel configuration option
anyway and will enable it if needed.

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/

