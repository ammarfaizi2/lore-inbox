Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277161AbRJMWh6>; Sat, 13 Oct 2001 18:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278430AbRJMWht>; Sat, 13 Oct 2001 18:37:49 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51011 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S277161AbRJMWha>; Sat, 13 Oct 2001 18:37:30 -0400
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
In-Reply-To: <20011013205445.A24854@kushida.jlokier.co.uk>
	<Pine.LNX.4.33.0110131219520.8900-100000@penguin.transmeta.com>
	<20011013214603.A1144@kushida.jlokier.co.uk>
	<20011013144337.D9856@vitelus.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Oct 2001 16:27:48 -0600
In-Reply-To: <20011013144337.D9856@vitelus.com>
Message-ID: <m1r8s7qior.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Lehmann <aaronl@vitelus.com> writes:

> On Sat, Oct 13, 2001 at 09:46:03PM +0200, Jamie Lokier wrote:
> > There are applications (GCC comes to mind) which are using mmap() to
> > read files now because it is measurably faster than read(), for
> > sufficiently large source files.
> 
> But it does have the advantage of allowing the sharing of memory, does
> it not?

Only if you are going to write to the data.

Eric
