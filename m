Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316898AbSFZVME>; Wed, 26 Jun 2002 17:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316910AbSFZVMD>; Wed, 26 Jun 2002 17:12:03 -0400
Received: from holomorphy.com ([66.224.33.161]:63699 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316898AbSFZVMD>;
	Wed, 26 Jun 2002 17:12:03 -0400
Date: Wed, 26 Jun 2002 14:11:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Amos Waterland <apw@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: O_ASYNC question
Message-ID: <20020626211122.GL22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Amos Waterland <apw@us.ibm.com>, linux-kernel@vger.kernel.org
References: <20020625113052.A7510@kvasir.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020625113052.A7510@kvasir.austin.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2002 at 11:30:52AM -0500, Amos Waterland wrote:
> The man page for fcntl() says:
>     If you set the O_ASYNC status flag on a file descriptor (either by
>     providing this flag with the open(2) call, or by using the F_SETFL
>     command of fcntl), a SIGIO signal is sent whenever input or output
>     becomes possible on that file descriptor.

Not done for files and you need fsetown() for sockets and tty's.


Cheers,
Bill
