Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbVHWJh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbVHWJh2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 05:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbVHWJh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 05:37:28 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:32021 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932110AbVHWJh1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 05:37:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oGPePeDb0MqudMmg1ELwsNGrW+9LIETxtfg1jZD0UgvEJY/LER5tCPui1V9Rqo6DfaLDtUgleeqG3B3HCTUscnxFLzdWFgrDPeGz8bFED9etn0AYwD9bIeCzvUWGe0kq4EYXggCdpJi+Tbs8QlpROM7kTJbaMgn1GQG1h1dGHP4=
Message-ID: <5a2cf1f6050823023741682524@mail.gmail.com>
Date: Tue, 23 Aug 2005 11:37:24 +0200
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Tomasz Chmielewski <mangoo@mch.one.pl>
Subject: Re: mass "tulip_stop_rxtx() failed", network stops
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <430AE85E.5040002@mch.one.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <430AE85E.5040002@mch.one.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/05, Tomasz Chmielewski <mangoo@mch.one.pl> wrote:
> We are running almost 20 Fujitsu-Siemens Scenic machines, 2.6.8.1
> kernel, equipped with a onboard card that uses a tulip module:
> 
> 02:01.0 Ethernet controller: Linksys NC100 Network Everywhere Fast
> Ethernet 10/100 (rev 11)
> 
> No problem with those.
> 
> 
> We are running four more machines like that, the only difference is the
> kernel they are running (2.6.11.4).
> 
> On some of them, there are serious problems with a network, and they
> usually happen when the traffic is bigger than usual (i.e., some big
> software deployment to several workstations, remote backup, etc.).
> 
> The syslog is then full of entries like that:
> 
> Aug 21 04:04:30 SERVER-B-HS kernel: NETDEV WATCHDOG: eth0: transmit
> timed out
> Aug 21 04:04:30 SERVER-B-HS kernel: 0000:00:06.0: tulip_stop_rxtx() failed

I am seeing thousands of tulip_stop_rxtx() failed messages as well
with 2.6.11. No regular network failure though.

See http://kerneltrap.org/mailarchive/1/message/110291/flat

Cheers,

Jerome
