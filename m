Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161126AbWG1J1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161126AbWG1J1E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 05:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161124AbWG1J1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 05:27:03 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:24765 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161123AbWG1J1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 05:27:01 -0400
Subject: Re: Hello, We have IP100A Linux driver need to submit to 2.6.x
	kernel
From: Arjan van de Ven <arjan@infradead.org>
To: Jesse Huang <jesse@icplus.com.tw>
Cc: Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <040401c6b1e8$e8b14ae0$4964a8c0@icplus.com.tw>
References: <02fb01c6b147$b15b8fc0$4964a8c0@icplus.com.tw>
	 <20060727190707.GA24157@electric-eye.fr.zoreil.com>
	 <040401c6b1e8$e8b14ae0$4964a8c0@icplus.com.tw>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 28 Jul 2006 11:26:40 +0200
Message-Id: <1154078800.3117.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 09:55 +0800, Jesse Huang wrote:
> Hi Francois:
> 
>     Sorry, I don't know this patch before. IP100A is a new version of IP100
> (sundance.c). I don't know what is you suggestion of IP100A driver? Should
> I...
> 
> 1. Only updata sundance.c to support IP100A
> 2. Release ip100a.c which support ip100(sundance) to kernel 2.6.x and ask to
> remove sundance.c.
> 3. Release ip100a.c with sundance.c both to kernel 2.6.x
> 
> We hope to use IP100a.c as our product driver, so 2. and 3. will better for
> IC Plus. But we will still follow your suggestion, if you feel 1. was better
> for kernel.


Hello,

in general the policy for Linux is that if adding support for a new
device is only minor changes to an existing driver, it is better to
update this existing driver with those changes. The reason for that is
that this makes it possible to share bugfixes and testing between both
devices. Now there is a point where it no longer makes sense to share,
for example when the devices are really very, very different. 

Greetings,
   Arjan van de Ven

