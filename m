Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbUCQSP7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 13:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbUCQSP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 13:15:59 -0500
Received: from web60709.mail.yahoo.com ([216.109.117.232]:64701 "HELO
	web60709.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261899AbUCQSPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 13:15:37 -0500
Message-ID: <20040317181537.43286.qmail@web60709.mail.yahoo.com>
Date: Wed, 17 Mar 2004 10:15:37 -0800 (PST)
From: VINOD GOPAL <vinod_gopal74@yahoo.com>
Subject: Re: arithmetic functions for linux driver
To: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200403171811.i2HIBA7o000386@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The range of input is varying.
Iam looking for floating point arithmetic functions
like log10, pow , sin ,exp , cos etc.

-vg
--- John Bradford <john@grabjohn.com> wrote:
> >  I need to use the arithmetic functions like sin,
> cos,
> > exp, log, etc in linux device driver.
> > 
> >  On search read , not to use libm from kernel
> driver
> > as it will harm the fpu registers.
> >   
> >   Do you have any insight how to support these
> > functions in linux driver or any code that is
> > available which I can make use of?
> 
> What exactly are you trying to do?  Why not simply
> create a look up
> table for the functions you need, if the expected
> range of input
> values is small?
> 
> John.


__________________________________
Do you Yahoo!?
Yahoo! Mail - More reliable, more storage, less spam
http://mail.yahoo.com
