Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316746AbSF0A5n>; Wed, 26 Jun 2002 20:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316755AbSF0A5m>; Wed, 26 Jun 2002 20:57:42 -0400
Received: from holomorphy.com ([66.224.33.161]:52692 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316746AbSF0A5m>;
	Wed, 26 Jun 2002 20:57:42 -0400
Date: Wed, 26 Jun 2002 17:56:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Amos Waterland <apw@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Tom Gall <tom_gall@vnet.ibm.com>,
       bcrl@redhat.com
Subject: Re: O_ASYNC question
Message-ID: <20020627005650.GN22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Amos Waterland <apw@us.ibm.com>, linux-kernel@vger.kernel.org,
	Tom Gall <tom_gall@vnet.ibm.com>, bcrl@redhat.com
References: <20020625113052.A7510@kvasir.austin.ibm.com> <20020626211122.GL22961@holomorphy.com> <20020626163755.A10713@kvasir.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020626163755.A10713@kvasir.austin.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2002 at 04:37:55PM -0500, Amos Waterland wrote:
> The reason that I was interested is that this behavior, if implemented
> for all fd types, would be useful for a scalable user-space
> implementation of POSIX aio.

Linux implements SIGIO for tty's and sockets only.

On Wed, Jun 26, 2002 at 04:37:55PM -0500, Amos Waterland wrote:
> When you say that it is 'not done for files', does that mean that it is
> not done by design, and no plans exist to implement it for files
> (perhaps because completion notification is fundamentally different than
> readiness notification?), or that the work just has yet to be done?
> Thanks.

It is not done by design. Future plans for async I/O implementations do
not appear to involve the SIGIO mechanism.


Cheers,
Bill
