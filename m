Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbTGFUcB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 16:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263451AbTGFUcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 16:32:01 -0400
Received: from fed1mtao01.cox.net ([68.6.19.244]:11943 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S263407AbTGFUb7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 16:31:59 -0400
Date: Sun, 6 Jul 2003 13:46:30 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] heavy disk access sometimes freezes 2.5.73-mm[123]
Message-ID: <20030706204630.GA2904@ip68-4-255-84.oc.oc.cox.net>
References: <20030703090541.GB5044@ip68-101-124-193.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030703090541.GB5044@ip68-101-124-193.oc.oc.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 02:05:41AM -0700, Barry K. Nathan wrote:
> When I run 2.5.73-mm[123] on a Mandrake Cooker system here, it generally
> runs fine. However, when I run "urpmi --auto-select" to upgrade the
> packages to the latest versions, rpm tends to freeze up during
> installation of one of the packages. This did not seem to happen with
> 2.5.70-mm9, which was the kernel I ran before 2.5.73-mm1.
[snip]

I've figured things out a bit more and filed a Bugzilla report:
http://bugme.osdl.org/show_bug.cgi?id=877

-Barry K. Nathan <barryn@pobox.com>
