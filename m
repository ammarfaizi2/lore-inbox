Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314203AbSDQXhQ>; Wed, 17 Apr 2002 19:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314204AbSDQXgL>; Wed, 17 Apr 2002 19:36:11 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:55733 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S314203AbSDQXgJ>; Wed, 17 Apr 2002 19:36:09 -0400
Date: Wed, 17 Apr 2002 17:34:21 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Adam Kropelin <akropel1@rochester.rr.com>
cc: Rick Stevens <rstevens@vitalstream.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.8-dj1 : arch/i386/kernel/smpboot.c error
Message-ID: <1873390000.1019090061@flay>
In-Reply-To: <20020417204037.GA292@www.kroptech.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Indeed. The optimization step that (presumably) removes the body
> of the if() must happen after the body has been fully evaluated.
> Makes sense, I guess, now that I think about it...

Personally, I think that's a really sick and twisted way for a compiler
to work ... what the hell is the point of compiling something you know
perfectly well you're going to dispose of 2 nanoseconds later?

M.


