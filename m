Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313691AbSDHQPO>; Mon, 8 Apr 2002 12:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313692AbSDHQPN>; Mon, 8 Apr 2002 12:15:13 -0400
Received: from velli.mail.jippii.net ([195.197.172.114]:47551 "HELO
	velli.mail.jippii.net") by vger.kernel.org with SMTP
	id <S313691AbSDHQPM>; Mon, 8 Apr 2002 12:15:12 -0400
Date: Mon, 8 Apr 2002 19:17:21 +0300
From: Anssi Saari <as@sci.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: PROMBLEM: CD burning at 16x uses excessive CPU, although DMA is enabled
Message-ID: <20020408161721.GA18233@sci.fi>
In-Reply-To: <Pine.LNX.3.96.1020408104857.21476C-100000@gatekeeper.tmr.com> <1018278394.570.143.camel@psuedomode>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2002 at 11:06:28AM -0400, Ed Sweetman wrote:
> I'm not completely sure about burning audio, but linux doesn't read
> audio cds using DMA.

I didn't think this is relevant, except if I were trying to copy a CD on
the fly, but that's not the case. But I have now tried it, no change. In
fact, what I tried was this linux-2.4.19-pre5-jam2 patch collection
which includes that and low latency and O(1) scheduler patches, among
other things.  Didn't seem to help, however.

