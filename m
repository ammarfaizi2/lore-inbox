Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVAMGLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVAMGLg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 01:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVAMGLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 01:11:36 -0500
Received: from main.gmane.org ([80.91.229.2]:13991 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261160AbVAMGLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 01:11:35 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: TG3 driver dies with "irq 12: nobody cared" on 2.6.10 (x86)
Date: Thu, 13 Jan 2005 11:13:14 +0500
Message-ID: <cs53eb$jfe$1@sea.gmane.org>
References: <2628963E-6521-11D9-B39A-0030656D1AB0@sigkill.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: inet.ycc.ru
User-Agent: KNode/0.8.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Laird wrote:

> I'm having a huge pile of problems with my home file server.  Since
> upgrading from 2.6.2 to 2.6.10, the box now falls off the network at
> the drop of a hat.  Here's one round of logs:
> 
> Jan 12 17:16:49 nfs kernel: irq 12: nobody cared!
> Jan 12 17:16:49 nfs kernel:  [<c012a2ea>] __report_bad_irq+0x2a/0x90
> Does anyone have any suggestions?

Try booting with noapic and see if this helps.

-- 
Alexander E. Patrakov

