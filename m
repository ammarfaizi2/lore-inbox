Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbTDXJC5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 05:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbTDXJC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 05:02:56 -0400
Received: from holomorphy.com ([66.224.33.161]:18856 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261970AbTDXJCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 05:02:50 -0400
Date: Thu, 24 Apr 2003 02:14:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, rml@tech9.net
Subject: Re: 2.5.68-mm2
Message-ID: <20030424091454.GP8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, rml@tech9.net
References: <20030423012046.0535e4fd.akpm@digeo.com> <20030423095926.GJ8931@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423095926.GJ8931@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 02:59:26AM -0700, William Lee Irwin III wrote:
> rml and I coordinated to put together a small patch (combining both
> our own) for properly locking the static variables in out_of_memory().
> There's not any evidence things are going wrong here now, but it at
> least addresses the visible lack of locking in out_of_memory().
> Applies cleanly to 2.5.68-mm2.

Improved OOM killer behavior verified on 64GB i386.


-- wli
