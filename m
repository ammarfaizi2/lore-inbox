Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbTJRFrj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 01:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbTJRFrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 01:47:39 -0400
Received: from holomorphy.com ([66.224.33.161]:53386 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261347AbTJRFri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 01:47:38 -0400
Date: Fri, 17 Oct 2003 22:50:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Duncan Haldane <f.duncan.m.haldane@worldnet.att.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8: broken  /fs/proc/array.c  compilation
Message-ID: <20031018055045.GI25291@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Duncan Haldane <f.duncan.m.haldane@worldnet.att.net>,
	linux-kernel@vger.kernel.org
References: <20031018052609.GH25291@holomorphy.com> <XFMail.20031018014148.f.duncan.m.haldane@worldnet.att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <XFMail.20031018014148.f.duncan.m.haldane@worldnet.att.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-Oct-2003 William Lee Irwin III wrote:
>> Compiler bogon, not kernel.

On Sat, Oct 18, 2003 at 01:41:48AM -0400, Duncan Haldane wrote:
> OK, This is the Red Hat 7.3 version of "gcc-2.96-113", which
> is "special" (RedHat-patched).  It's reacting to the changes in 2.6.0-test8. 
> Does this mean that this compiler has now become unusable for 2.6.0 > test7
> with /proc support?

I don't know anything about that compiler. You may have to ask RH to
provide a fix.

In general, the register allocator shouldn't shit its pants.


-- wli
