Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283384AbRK2VEE>; Thu, 29 Nov 2001 16:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283392AbRK2VDz>; Thu, 29 Nov 2001 16:03:55 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:30194
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S283384AbRK2VDs>; Thu, 29 Nov 2001 16:03:48 -0500
Date: Thu, 29 Nov 2001 13:03:42 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Robert Love <rml@tech9.net>
Cc: McEnroe <mcensamuel@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: interrupt ?
Message-ID: <20011129130342.B496@mikef-linux.matchmail.com>
Mail-Followup-To: Robert Love <rml@tech9.net>,
	McEnroe <mcensamuel@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3C043B11.2FA17A19@pobox.com> <3C05B561.75F210C7@pobox.com> <001601c17873$c664ee00$8b64a8c0@PREM> <1007053658.813.17.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1007053658.813.17.camel@phantasy>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2001 at 12:07:37PM -0500, Robert Love wrote:
> On Wed, 2001-11-28 at 20:18, McEnroe wrote:
> 
> > what is fast and slow interrupt ?
> > what is the difference between this ?
> 
> fast interrupts occur with interrupts disabled, and are expected to be
> completed quickly -- they are performed by the interrupt handlers
> themselves.
> 
> a slow interrupt occurs with interrupts enabled, such as bottom half
> tasks.
> 

IIRC, bottom half is mostly used by network packet processing.
