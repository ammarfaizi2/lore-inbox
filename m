Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161082AbWHRTV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161082AbWHRTV2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 15:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWHRTV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 15:21:28 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:6589 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932483AbWHRTV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 15:21:27 -0400
Subject: Re: Serial issue
From: Lee Revell <rlrevell@joe-job.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Paul Fulghum <paulkf@microgate.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.61.0608181512520.19876@chaos.analogic.com>
References: <1155862076.24907.5.camel@mindpipe>
	 <1155915851.3426.4.camel@amdx2.microgate.com>
	 <1155923734.2924.16.camel@mindpipe>  <44E602C8.3030805@microgate.com>
	 <1155925024.2924.22.camel@mindpipe>
	 <Pine.LNX.4.61.0608181512520.19876@chaos.analogic.com>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 15:21:25 -0400
Message-Id: <1155928885.2924.40.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 15:15 -0400, linux-os (Dick Johnson) wrote:
> A file-transfer protocol??? Has he got hardware the __required__
> hardware flow-control enabled on both ends? One can't spew
> high-speed serial data out forever without a hardware handshake.
> 

Interesting you should mention that.  As a matter of fact I have to
disable all flow control or the serial console doesn't even work.  I
considered this a minor issue and had forgotten about it.

But, in polled mode with no flow control I can transfer a 10MB file.
There are a lot of retransmits but it works.

Lee

