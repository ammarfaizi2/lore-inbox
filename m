Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278419AbRJMVnY>; Sat, 13 Oct 2001 17:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278417AbRJMVnO>; Sat, 13 Oct 2001 17:43:14 -0400
Received: from vitelus.com ([64.81.243.207]:57862 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S278419AbRJMVnJ>;
	Sat, 13 Oct 2001 17:43:09 -0400
Date: Sat, 13 Oct 2001 14:43:37 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
Message-ID: <20011013144337.D9856@vitelus.com>
In-Reply-To: <20011013205445.A24854@kushida.jlokier.co.uk> <Pine.LNX.4.33.0110131219520.8900-100000@penguin.transmeta.com> <20011013214603.A1144@kushida.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011013214603.A1144@kushida.jlokier.co.uk>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2001 at 09:46:03PM +0200, Jamie Lokier wrote:
> There are applications (GCC comes to mind) which are using mmap() to
> read files now because it is measurably faster than read(), for
> sufficiently large source files.

But it does have the advantage of allowing the sharing of memory, does
it not?
