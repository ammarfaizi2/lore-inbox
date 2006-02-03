Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbWBCLji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbWBCLji (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 06:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWBCLji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 06:39:38 -0500
Received: from server02.es6.egwn.net ([195.10.6.12]:52449 "EHLO
	mx1.es6.egwn.net") by vger.kernel.org with ESMTP id S1750928AbWBCLjh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 06:39:37 -0500
Subject: Re: [RFC 4/4] firewire: add mem1394
From: Andy Wingo <wingo@pobox.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
In-Reply-To: <1138920185.3621.24.camel@localhost>
References: <1138919238.3621.12.camel@localhost>
	 <1138920185.3621.24.camel@localhost>
Content-Type: text/plain
Date: Fri, 03 Feb 2006 12:35:21 +0100
Message-Id: <1138966521.4914.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

On Thu, 2006-02-02 at 23:43 +0100, Johannes Berg wrote:
> +	spin_lock(&dev_list_lock);

Stupid question: are you sure that something coming from an interrupt
handler won't try to grab this lock? For example from a cable unplug?

Regards,
-- 
Andy Wingo
http://wingolog.org/

