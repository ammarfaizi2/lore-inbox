Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWHKN7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWHKN7a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 09:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWHKN73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 09:59:29 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63887 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750794AbWHKN73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 09:59:29 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christoph Hellwig <hch@infradead.org>
Cc: merlin@sztaki.hu, linux-kernel@vger.kernel.org
Subject: Re: question about kill PIDTYPE_TGID patch
References: <200608091323.12426.merlin@sztaki.hu>
	<20060809112922.GA15224@infradead.org>
Date: Fri, 11 Aug 2006 07:58:56 -0600
In-Reply-To: <20060809112922.GA15224@infradead.org> (Christoph Hellwig's
	message of "Wed, 9 Aug 2006 12:29:22 +0100")
Message-ID: <m1lkpvz84f.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Wed, Aug 09, 2006 at 01:23:12PM +0200, merlin@sztaki.hu wrote:
>> Hello,
>> 
>> I'm trying to compile IBM GPFS(2.3.0-15) Portability Layer with a 2.6.16 
>> kernel (2.6.16-1.2289_FC6-xen-i686). The compiler stops with 
>> the error message below:
>> 
>> kdump-kern.c:163: error: `PIDTYPE_TGID' undeclared (first use in this 
>> function)
>> 
>> As I think, this is because of the PIDTYPE_TGID patch. 
>> 
>> I don't want to get out that patch from the kernel , if there's
>> a more simple solution.
>> 
>> I hope you can suggest me a solution for the three lines where PIDTYPE_TGID
>> appears (see below) in the source code.
>
> Just stop using broken, propritary out of tree code.  If you refuse to
> do that go to your IBM support contact and whine to them, it's their fault
> after all.

What makes this very funny is that if the GPFS code had called the appropriate
function it would not have broken.  The appropriate function is the same
in 2.4.x as it is in 2.6.

Eric
