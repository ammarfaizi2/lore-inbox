Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275062AbTHRVCl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 17:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275092AbTHRVCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 17:02:41 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:19211
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S275062AbTHRVCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 17:02:40 -0400
Date: Mon, 18 Aug 2003 14:02:38 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Hank Leininger <hlein@progressive-comp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dumb question: Why are exceptions such as SIGSEGV not logged
Message-ID: <20030818210238.GG10320@matchmail.com>
Mail-Followup-To: Hank Leininger <hlein@progressive-comp.com>,
	linux-kernel@vger.kernel.org
References: <200308182050.h7IKonga016378@marc2.theaimsgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308182050.h7IKonga016378@marc2.theaimsgroup.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 04:50:49PM -0400, Hank Leininger wrote:
> ..So not *all* such cases are cause for alarm.  However, if you run one of
> the patches enabling logging of this, you quickly learn what's normal for
> the apps you run, and can teach your log-auditing tools and/or your brain
> to ignore them.

And why not just catch the ones sent from the kernel?  That's the one that
is killing the program because it crashed, and that's the one the origional
poster wants logged...
