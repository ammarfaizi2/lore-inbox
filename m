Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWJEF1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWJEF1V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 01:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWJEF1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 01:27:21 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:64715 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751128AbWJEF1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 01:27:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZIO0Lj6XCZa4akLhtAMv5Op6MAufMHMQCa/w3SG7bQo1osSBp6olq6iBbJOt83oMYvLj+WEbqX2PkRKrJuW6dZvD1h5So4zOjwtj7q+EFWEZA5ix+bDGbsOVrhT+p0gzoUruRSdn682opDFwNaIXWW5h8dfF7eu0HR2kTq1lRIg=
Message-ID: <9a0545880610042227i7960737alb49480c609cff802@mail.gmail.com>
Date: Wed, 4 Oct 2006 22:27:18 -0700
From: "Steve Hindle" <mech422@gmail.com>
To: "David Chinner" <dgc@sgi.com>
Subject: Re: PROBLEM: Hardlock with 2.6.1[678] on Abit AI7, ICH5 + XFS, SATA under heavy I/O load
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
In-Reply-To: <20061005043154.GA11811@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a0545880610041828w658d7aaco20348d54e9321d8f@mail.gmail.com>
	 <20061005043154.GA11811@melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/06, David Chinner <dgc@sgi.com> wrote:
> On Wed, Oct 04, 2006 at 06:28:35PM -0700, Steve Hindle wrote:
> > Hello,
> >
> >  My machine is hardlocking with recent kernels (including 2.6.18-mm3)
> > under heavy I/O load (for instance, just compiling the kernel is
> > enough to lock the machine).  No bug,oops,or panic and nothing in the
> > system logs.
>
> Does it happen on any other filesystems? Is this your root filesystem
> that is hanging?
>
no, its not my root - but my other partitions are also XFS and are on
the same drive...
so not really any way to check ATM.

> Journalling filesystems shouldn't get corrupted by hangs or
> crashes...

I understood this in theory - but was rather pleased theory == practice.
However, I didn't even notice a 'not unmounted cleanly' message during
subsequent boots?
I might just have missed it though - Debian's boot has gotten much
'chattier' over the years...

Steve
