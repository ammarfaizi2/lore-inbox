Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286462AbSAUNva>; Mon, 21 Jan 2002 08:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286590AbSAUNvY>; Mon, 21 Jan 2002 08:51:24 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:14608 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S286462AbSAUNvM>; Mon, 21 Jan 2002 08:51:12 -0500
Date: Mon, 21 Jan 2002 16:51:03 +0300
From: Oleg Drokin <green@namesys.com>
To: Fabio Fracassi <turiya@linuxfromscratch.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Complete lockup when using g++ on reiserfs
Message-ID: <20020121165103.A4915@namesys.com>
In-Reply-To: <16Sckv-03IJKyC@fmrl01.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16Sckv-03IJKyC@fmrl01.sul.t-online.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Jan 21, 2002 at 12:41:02PM +0100, Fabio Fracassi wrote:

> I suppose the Problem is somewhere in the ReiserFs part, since when this hang
> happens the last processed c++ file sometimes gets corrupted.
I won;t be so sure about that.
It may be that hang appears elsewhere, and reiserfs just have no time
to fill allocated data block with meaningful data.
Reiserfs does not offer data journaling, so only metadata consistiency is
there.
What you are describing looks more like faulty hardware.

Bye,
    Oleg
