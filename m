Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262935AbTHUXrR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 19:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262938AbTHUXrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 19:47:16 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:35334
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262937AbTHUXrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 19:47:13 -0400
Date: Thu, 21 Aug 2003 16:47:09 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Takao Indoh <indou.takao@soft.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cache limit
Message-ID: <20030821234709.GD1040@matchmail.com>
Mail-Followup-To: Takao Indoh <indou.takao@soft.fujitsu.com>,
	linux-kernel@vger.kernel.org
References: <3F41AA15.1020802@verizon.net> <5C3677E1D3B41indou.takao@soft.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C3677E1D3B41indou.takao@soft.fujitsu.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 09:49:45AM +0900, Takao Indoh wrote:
> Actually, in the system I constructed(RedHat AdvancedServer2.1, kernel
> 2.4.9based), the problem occurred due to pagecache. The system's maximum
> response time had to be less than 4 seconds, but owing to the pagecache,
> response time get uneven, and maximum time became 10 seconds.

Please try the 2.4.18 based redhat kernel, or the 2.4-aa kernel.
