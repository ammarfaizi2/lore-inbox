Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbWDNS3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbWDNS3L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 14:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWDNS3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 14:29:10 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:28396 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751391AbWDNS3J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 14:29:09 -0400
Subject: Re: [PATCH] make: add modules_update target
From: Dustin Kirkland <dustin.kirkland@us.ibm.com>
Reply-To: Dustin Kirkland <dustin.kirkland@us.ibm.com>
To: Avi Kivity <avi@argo.co.il>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Kylene Jo Hall <kjhall@us.ibm.com>,
       kbuild-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <443FE350.5040502@argo.co.il>
References: <1145027216.12054.164.camel@localhost.localdomain>
	 <20060414170222.GA19172@thunk.org>  <443FE350.5040502@argo.co.il>
Content-Type: text/plain
Organization: IBM
Date: Fri, 14 Apr 2006 13:29:07 -0500
Message-Id: <1145039347.3074.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-14 at 21:00 +0300, Avi Kivity wrote:
> How about using rsync with --delete as a substitute for cp (if rsync is 
> available)?

I thought about this, but a "grep -r rsync" didn't turn up any previous
hits in the kernel build process.  I didn't want to introduce this as a
new dependency for kernel building, if it's possible to avoid...


:-Dustin


