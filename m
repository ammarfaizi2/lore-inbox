Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWCIXUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWCIXUY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWCIXUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:20:24 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:28223 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S932091AbWCIXUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:20:23 -0500
X-IronPort-AV: i="4.02,180,1139212800"; 
   d="scan'208"; a="1783640910:sNHT31196632"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 9 of 20] ipath - char devices for diagnostics and lightweight subnet management
X-Message-Flag: Warning: May contain useful information
References: <eac2ad3017b5f160d24c.1141922822@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 09 Mar 2006 15:20:15 -0800
In-Reply-To: <eac2ad3017b5f160d24c.1141922822@localhost.localdomain> (Bryan O'Sullivan's message of "Thu,  9 Mar 2006 08:47:02 -0800")
Message-ID: <adalkvjfbo0.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Mar 2006 23:20:15.0259 (UTC) FILETIME=[0595A6B0:01C643D0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan> The ipath_sma.c file supports a lightweight userspace
    Bryan> subnet management agent (SMA).  This is used in deployments
    Bryan> (such as HPC clusters) where a full Infiniband protocol
    Bryan> stack is not needed.

I've never understood what forces you to maintain two separate SMAs.
Why can't you pick one of the two SMAs and use that unconditionally?

 - R.
