Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262399AbVDGJMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbVDGJMx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 05:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262401AbVDGJMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 05:12:53 -0400
Received: from smtpout19.mailhost.ntl.com ([212.250.162.19]:11805 "EHLO
	mta13-winn.mailhost.ntl.com") by vger.kernel.org with ESMTP
	id S262399AbVDGJMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 05:12:43 -0400
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
From: Ian Campbell <ijc@hellion.org.uk>
To: johnpol@2ka.mipt.ru
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>, greg@kroah.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1112861638.28858.92.camel@uganda>
References: <1112859412.18360.31.camel@frecb000711.frec.bull.fr>
	 <1112860419.28858.76.camel@uganda>  <1112861638.28858.92.camel@uganda>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 10:12:32 +0100
Message-Id: <1112865153.3086.134.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-07 at 12:13 +0400, Evgeniy Polyakov wrote:
> The main idea was to simplify userspace control and notification
> system - so people did not waste it's time learning how skb's are
> allocated
> and processed, how socket layer is designed and what all those
> netlink_* and NLMSG* mean if they do not need it.

Isn't connector built on top of netlink? If so, is there any reason for
it to be a new subsystem rather than an extension the the netlink API?

Ian.
-- 
Ian Campbell

Employees and their families are not eligible.

