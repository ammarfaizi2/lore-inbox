Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbVKIP7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbVKIP7e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 10:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbVKIP7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 10:59:34 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:42819
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751430AbVKIP7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 10:59:33 -0500
Message-Id: <43722B2E.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Wed, 09 Nov 2005 17:00:30 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Al Viro" <viro@ftp.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 15/39] NLKD - early pseudo-fs
References: <43720F5E.76F0.0078.0@novell.com>  <43720F95.76F0.0078.0@novell.com>  <43720FBA.76F0.0078.0@novell.com>  <43720FF6.76F0.0078.0@novell.com>  <43721024.76F0.0078.0@novell.com>  <4372105B.76F0.0078.0@novell.com>  <43721119.76F0.0078.0@novell.com>  <43721142.76F0.0078.0@novell.com>  <20051109142926.GU7992@ftp.linux.org.uk>  <4372179E.76F0.0078.0@novell.com> <20051109150057.GX7992@ftp.linux.org.uk>
In-Reply-To: <20051109150057.GX7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Al Viro <viro@ftp.linux.org.uk> 09.11.05 16:00:57 >>>
>On Wed, Nov 09, 2005 at 03:37:02PM +0100, Jan Beulich wrote:
>> >What the hell for?  We _already_ have a way to get any set of
files
>> in
>> >a filesystem as soon as we have VFS caches set up (and until then
you
>> >can't open anything anyway).
>> 
>> That's the whole point - a debugger wants this *before* VFS is set
up
>> (and thus obviously without going through VFS in the first place).
One
>> may argue that the naming is odd, but that's nothing I really care
>> about.
>> 
>> >NAK.
>> 
>> Then suggest an alternative solution.
>
>"Reduce the parts of your config needed that early on to something
>saner in size"

That is no solution. Take a look at what can be configured in NLKD, and
tell me what you'd call a 'saner in size' subset. I can't think of
anything that can be left out; instead, the amount of configurable
things will only grow over time.

Jan
