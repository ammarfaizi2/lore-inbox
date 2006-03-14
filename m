Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751767AbWCNGuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbWCNGuk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 01:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbWCNGuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 01:50:40 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:34177 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751767AbWCNGuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 01:50:39 -0500
Date: Tue, 14 Mar 2006 12:20:22 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [Patch 1/9] timestamp diff
Message-ID: <20060314065022.GA5748@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <1142296834.5858.3.camel@elinux04.optonline.net> <1142296939.5858.6.camel@elinux04.optonline.net> <1142298072.13256.70.camel@mindpipe> <1142298325.5858.40.camel@elinux04.optonline.net> <1142298764.13256.73.camel@mindpipe> <661de9470603131942k768d672eq6009769ec58a4329@mail.gmail.com> <441645FB.6000002@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441645FB.6000002@watson.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Lee's point is valid....we should be doing the set_normalized_timespec.
>

Semantically that sounds correct. But the intension of the caller as in
our case could be to convert the timespec to nsec_t. Calling
set_normalized_timespec() might be an overhead in this case. 

Balbir
