Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbUATCMA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 21:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265233AbUATCJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 21:09:19 -0500
Received: from dp.samba.org ([66.70.73.150]:22182 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265303AbUATCHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 21:07:15 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] add class_simple support [01/10] 
In-reply-to: Your message of "Thu, 15 Jan 2004 12:41:11 -0800."
             <20040115204111.GB22199@kroah.com> 
Date: Tue, 20 Jan 2004 12:58:30 +1100
Message-Id: <20040120020710.A92E92C2DA@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040115204111.GB22199@kroah.com> you write:
> +	list_for_each(tmp, &simple_dev_list) {
> +		s_dev = list_entry(tmp, struct simple_dev, node);

Hi again Greg.

Insert a gentle reminder about list_for_each_entry here.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
