Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263329AbTJQHvV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 03:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbTJQHvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 03:51:21 -0400
Received: from holomorphy.com ([66.224.33.161]:63622 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263329AbTJQHvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 03:51:20 -0400
Date: Fri, 17 Oct 2003 00:54:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zan Lynx <zlynx@acm.org>
Cc: Albert Cahalan <albert@users.sf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: /proc reliability & performance
Message-ID: <20031017075428.GC25291@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zan Lynx <zlynx@acm.org>, Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1066356438.15931.125.camel@cube> <1066376402.4401.2.camel@titania.zlynx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066376402.4401.2.camel@titania.zlynx.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-16 at 20:07, Albert Cahalan wrote:
>> I created a process with 360 thousand threads,
>> went into the /proc/*/task directory, and did
>> a simple /bin/ls. It took over 9 minutes on a
>> nice fast Opteron.

On Fri, Oct 17, 2003 at 01:40:03AM -0600, Zan Lynx wrote:
> Did you try using find instead of ls?  ls loads all entries and then
> sorts them, so it can create an alphabetical display.
> Try using find.  It will not take quite so long.

GNU ls has a -U flag that should come in handy.


-- wli
