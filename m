Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267024AbTAFQJl>; Mon, 6 Jan 2003 11:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267025AbTAFQJl>; Mon, 6 Jan 2003 11:09:41 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:58641 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S267024AbTAFQJk>; Mon, 6 Jan 2003 11:09:40 -0500
Date: Mon, 06 Jan 2003 09:18:03 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: David Lang <david.lang@digitalinsight.com>
cc: Paul Rolland <rol@witbe.net>, linux-kernel@vger.kernel.org
Subject: Re: [2.5.54] Oops IDE-SCSI and failure AIC7xxx
Message-ID: <275560000.1041869883@aslan.scsiguy.com>
In-Reply-To: <Pine.LNX.4.44.0301052105460.25514-100000@dlang.diginsite.com>
References: <Pine.LNX.4.44.0301052105460.25514-100000@dlang.diginsite.com>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> o  Compile in the debugging code for the aic7xxx driver and turn on some
>>    debugging options.  Use your favorite kernel configuration utility to
>>    enable the debug code and use an aic7xxx command line like:
>> 
>> 	aic7xxx=verbose.debug:0x12ff
> 
> I added this to lilo and it gets a series of messages that quickly scroll
> off the screen

I need to see the exact messages.  Can you use a serial console to
capture the messages?  To avoid unwanted command timeouts, you should
run your serial console at a reasonable speed (115200 or faster).

--
Justin
