Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbTDXITf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 04:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbTDXITf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 04:19:35 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:50055 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261816AbTDXITd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 04:19:33 -0400
Date: Thu, 24 Apr 2003 09:31:37 +0100
From: Jamie Lokier <jamie@shareable.org>
To: John Bradford <john@grabjohn.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flame Linus to a crisp!
Message-ID: <20030424083137.GF28253@mail.jlokier.co.uk>
References: <20030424074400.GD28253@mail.jlokier.co.uk> <200304240816.h3O8GGrH000399@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304240816.h3O8GGrH000399@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
> With open hardware designs, there would be no problem with
> documentation not being available to write drivers.

See below...

> Incidently, using the Transmeta CPUs, is it not possible for the user
> to replace the controlling software with their own code?  I.E. not
> bother with X86 compatibility at all, but effectively design your own
> CPU?  Couldn't we make the first Lin-PU this way?

In theory; in practice we have no access to documentation.  See above...

That makes Transmeta part of the _old_ industry :)

I believe present Transmeta CPUs are quite specialised for x86
behaviour (memory model etc.) anyway.  When you're running on a CPU
like that, there's probably little to be gained from changing to a
different front-end instruction set.

Special tricks like non-cache-ping-ponging locks and faster interrupt
handling might improve performance, but probably require a change of
the hardware to implement.

-- Jamie
