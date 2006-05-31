Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbWEaUgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbWEaUgt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 16:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbWEaUgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 16:36:48 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:15267 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S964914AbWEaUgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 16:36:47 -0400
X-IronPort-AV: i="4.05,194,1146466800"; 
   d="scan'208"; a="1816579744:sNHT31923412"
To: Steve Wise <swise@opengridcomputing.com>
Cc: mshefty@ichips.intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 1/7] AMSO1100 Makefiles and Kconfig changes.
X-Message-Flag: Warning: May contain useful information
References: <20060531182733.3652.54755.stgit@stevo-desktop>
	<20060531182735.3652.44197.stgit@stevo-desktop>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 31 May 2006 13:36:44 -0700
In-Reply-To: <20060531182735.3652.44197.stgit@stevo-desktop> (Steve Wise's message of "Wed, 31 May 2006 13:27:35 -0500")
Message-ID: <ada8xoix76r.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 31 May 2006 20:36:45.0243 (UTC) FILETIME=[EEA540B0:01C684F1]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you reorder things so these changes go last?  Otherwise after this
patch we're left with a kernel tree that has a Makefile that refers to
sources that don't exist yet.  It's not really a practical issue but
it is neater to do that way.

(It's easy to do in stgit -- just pop all the patches and then use
"stg push <name>" to push them in a different order)

 - R.
