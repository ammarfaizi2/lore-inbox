Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbUCQSI6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 13:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbUCQSI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 13:08:58 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:27264 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261906AbUCQSI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 13:08:56 -0500
Date: Wed, 17 Mar 2004 18:11:10 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200403171811.i2HIBA7o000386@81-2-122-30.bradfords.org.uk>
To: VINOD GOPAL <vinod_gopal74@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040317175939.75460.qmail@web60705.mail.yahoo.com>
References: <20040317175939.75460.qmail@web60705.mail.yahoo.com>
Subject: Re: arithmetic functions for linux driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  I need to use the arithmetic functions like sin, cos,
> exp, log, etc in linux device driver.
> 
>  On search read , not to use libm from kernel driver
> as it will harm the fpu registers.
>   
>   Do you have any insight how to support these
> functions in linux driver or any code that is
> available which I can make use of?

What exactly are you trying to do?  Why not simply create a look up
table for the functions you need, if the expected range of input
values is small?

John.
