Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVF2QGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVF2QGV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 12:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbVF2QGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 12:06:21 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:43595 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S261534AbVF2QGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 12:06:16 -0400
X-IronPort-AV: i="3.93,242,1115017200"; 
   d="scan'208"; a="646298079:sNHT25960648"
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 05/16] IB uverbs: core implementation
X-Message-Flag: Warning: May contain useful information
References: <2005628163.lUk0bfpO8VsSXUh5@cisco.com>
	<2005628163.jfSiMqRcI78iLMJP@cisco.com>
	<20050629002709.GB17805@kroah.com>
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 29 Jun 2005 09:06:15 -0700
Message-ID: <52acl9gnbc.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> This is no longer needed with the class device interface in
    Greg> the kernel today.  Please use the new api (basically just
    Greg> set dev_t in the class_device, and you get this for free.)

Thanks, I've killed that code and just set class_dev.devt instead.

 - R.
