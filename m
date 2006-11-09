Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161851AbWKIV6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161851AbWKIV6Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 16:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161854AbWKIV6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 16:58:24 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:42500 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1161851AbWKIV6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 16:58:23 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: Christoph Raisch <RAISCH@de.ibm.com>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 2.6.19 2/4] ehca: hcp_phyp.c: correct page mapping in 64k page mode
X-Message-Flag: Warning: May contain useful information
References: <aday7qngiuf.fsf@cisco.com>
	<OF60EFC2CD.F8FB1D23-ONC1257220.00315F90-C1257220.0038B8E3@de.ibm.com>
	<17746.52343.815568.368590@cargo.ozlabs.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 09 Nov 2006 13:58:21 -0800
In-Reply-To: <17746.52343.815568.368590@cargo.ozlabs.ibm.com> (Paul Mackerras's message of "Thu, 9 Nov 2006 17:36:39 +1100")
Message-ID: <adaodrgb7uq.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Nov 2006 21:58:22.0108 (UTC) FILETIME=[2C530DC0:01C7044A]
Authentication-Results: sj-dkim-3; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim3002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > So Roland is correct in his comment about how ioremap is called.

Umm, so is this patch really needed?  Where did the patch come from --
is it needed to fix something actually seen, or was it written just
based on some theoretical understanding?

I'm confused...

 - R.
