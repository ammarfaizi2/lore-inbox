Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319544AbSH3Ky0>; Fri, 30 Aug 2002 06:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319545AbSH3Ky0>; Fri, 30 Aug 2002 06:54:26 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:29166
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319544AbSH3KyZ>; Fri, 30 Aug 2002 06:54:25 -0400
Subject: Re: PROBLEM: nfs & "Warning - running *really* short on DMA buffers"
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D6F34B1.29073.4DAAB0@localhost>
References: <3D6F34B1.29073.4DAAB0@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 30 Aug 2002 11:58:54 +0100
Message-Id: <1030705134.3180.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-30 at 08:02, Pedro M. Rodrigues wrote:
>    Hello to all! While preparing to migrate some servers to Redhat 
> 7.3 and doing some nfs tests before deployment i came across this 
> "Warning - running *really* short on DMA buffers" error message 
> repeated several times in dmesg and /var/log/messages. Something like 
> this:

They are warnings not fatal, at most they slowed you down due to lack of
resources. You might want to tune the vm settings to keep more pages
reserved for atomic allocation

