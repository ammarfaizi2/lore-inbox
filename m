Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030372AbWI1TBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030372AbWI1TBG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 15:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161018AbWI1TBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 15:01:06 -0400
Received: from smtp-out.google.com ([216.239.45.12]:10350 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030372AbWI1TBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 15:01:04 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=WyaoFEL7p2OXXB0FY05NZGhAk4Si4UasJ4Z14STrVQoonDx8o2XwrNZWl1297OLV9
	Qhxa93d/bjJbYEpiBFGIg==
Message-ID: <6599ad830609281200n441e6c00kf68e042d94f83abe@mail.google.com>
Date: Thu, 28 Sep 2006 12:00:49 -0700
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [RFC][PATCH 0/4] Generic container system
Cc: akpm@osdl.org, ckrm-tech@lists.sourceforge.net, mbligh@google.com,
       rohitseth@google.com, winget@google.com, dev@sw.ru, sekharan@us.ibm.com,
       linux-kernel@vger.kernel.org, jlan@sgi.com
In-Reply-To: <20060928114939.d13c957b.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060928104035.840699000@menage.corp.google.com>
	 <20060928114939.d13c957b.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/06, Paul Jackson <pj@sgi.com> wrote:
>
> Question (perhaps already answered in your code - I haven't looked
> yet): can loadable kernel modules register containers?  I'd like to

There's no reason in principle why not, although this patch doesn't
export the symbols.

Paul
