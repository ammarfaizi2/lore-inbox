Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314356AbSDROCo>; Thu, 18 Apr 2002 10:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314357AbSDROCn>; Thu, 18 Apr 2002 10:02:43 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:6157 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S314356AbSDROCm>; Thu, 18 Apr 2002 10:02:42 -0400
Date: Thu, 18 Apr 2002 16:02:39 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: [OT: nostalgia] Re: SSE related security hole
Message-ID: <20020418140239.GF22378@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020417194249.B23438@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2002, Doug Ledford wrote:

> pxor instruction with xorps instead makes it work.  So, that's a bug in
> gcc I suspect, using sse2 instructions when only called to use sse
> instructions.  It seems odd to me that the CPU wouldn't generate an
> illegal instruction exception, but oh well, it evidently doesn't.

Remember ye goode olde 6502/6510 processors used in the famous Commodore
64 computers? These don't bail out when using undefined opcodes either,
some opcodes actually had undocumented but consistent behaviour and were
used in "my program is shorter than yours" 1000 byte demo contests and
the like.
