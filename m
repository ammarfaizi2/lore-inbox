Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264860AbUD2VYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264860AbUD2VYD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 17:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264870AbUD2VVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 17:21:00 -0400
Received: from holomorphy.com ([207.189.100.168]:31617 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264994AbUD2VS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 17:18:29 -0400
Date: Thu, 29 Apr 2004 14:18:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, James.Bottomley@steeleye.com
Subject: Re: 2.6.6-rc2-mm2
Message-ID: <20040429211825.GC783@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	James.Bottomley@steeleye.com
References: <20040426013944.49a105a8.akpm@osdl.org> <20040429184126.GB783@holomorphy.com> <20040429134546.5e9515d8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429134546.5e9515d8.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> I missed -mm1; both this and -mm1 appear to be unable to detect Adaptec
>> 39160 HBA's. I'm in the midst of bisecting this. Thus far I have the
>> last known-working as virgin 2.6.6-rc2, and first known broken is patch
>> #36 out of 308 i.e. it's probably in one of the external bk trees or
>> linus.patch, though linus.patch doesn't seem to have anything related.

On Thu, Apr 29, 2004 at 01:45:46PM -0700, Andrew Morton wrote:
> bk-scsi.patch will be the one to try.

Is there a split-up version of that anywhere I can do bisection search on?


-- wli
