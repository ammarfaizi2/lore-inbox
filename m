Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264005AbTH1Nny (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 09:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264019AbTH1Nny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 09:43:54 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:3767 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S264005AbTH1Nnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 09:43:53 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Thu, 28 Aug 2003 15:43:50 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Tejun Huh <tejun@aratech.co.kr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache statistics race in 2.4
Message-Id: <20030828154350.4239fb19.skraw@ithnet.com>
In-Reply-To: <20030828022748.GA20792@atj.dyndns.org>
References: <20030828022748.GA20792@atj.dyndns.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Aug 2003 11:27:49 +0900
Tejun Huh <tejun@aratech.co.kr> wrote:

>  Hello,
> 
>  In fs/dcache.c, dentry_stat.nr_dentry is not protected by anything
> and on a busy SMP machine, after a while, the count goes wild.

Can you shortly describe what user experiences in this case?

Regards,
Stephan
