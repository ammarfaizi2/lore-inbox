Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWJEA6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWJEA6F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 20:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWJEA6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 20:58:05 -0400
Received: from ns.suse.de ([195.135.220.2]:10186 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751288AbWJEA6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 20:58:02 -0400
From: Andi Kleen <ak@suse.de>
To: vgoyal@in.ibm.com
Subject: Re: 2.6.18-mm2 boot failure on x86-64
Date: Thu, 5 Oct 2006 02:57:53 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Steve Fox <drfickle@us.ibm.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       kmannth@us.ibm.com
References: <20060928014623.ccc9b885.akpm@osdl.org> <20061004170659.f3b089a8.akpm@osdl.org> <20061005005124.GA23408@in.ibm.com>
In-Reply-To: <20061005005124.GA23408@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610050257.53971.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I think most likely it would crash on 2.6.18. Keith mannthey had reported
> a different crash on 2.6.18-rc4-mm2 when this patch was introduced first
> time. Following is the link to the thread.

Then maybe trying 2.6.17 + the patch and then bisect between that and -rc4?

-Andi
