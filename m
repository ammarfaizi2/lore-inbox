Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbUCQUY5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 15:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbUCQUY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 15:24:57 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:897 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262051AbUCQUYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 15:24:54 -0500
Date: Wed, 17 Mar 2004 20:27:02 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200403172027.i2HKR2V3000636@81-2-122-30.bradfords.org.uk>
To: "Richard B. Johnson" <root@chaos.analogic.com>,
       VINOD GOPAL <vinod_gopal74@yahoo.com>
Cc: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0403171338500.19593@chaos>
References: <20040317181537.43286.qmail@web60709.mail.yahoo.com>
 <Pine.LNX.4.53.0403171338500.19593@chaos>
Subject: Re: arithmetic functions for linux driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from "Richard B. Johnson" <root@chaos.analogic.com>:
> On Wed, 17 Mar 2004, VINOD GOPAL wrote:
> 
> > The range of input is varying.
> > Iam looking for floating point arithmetic functions
> > like log10, pow , sin ,exp , cos etc.
> >
> 
> Like the range of input from an ADC? You get the data in
> the kernel and you muck with it in user-mode after you
> have it.

If the task in hand is anything much more complicated than getting the
input from an 8-bit ADC, and transforming it using a single function
such as sin, then yes, do it in userspace.

John.
