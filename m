Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbVCAUaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbVCAUaj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 15:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbVCAUai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 15:30:38 -0500
Received: from uucp.cistron.nl ([62.216.30.38]:43204 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S262055AbVCAUaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 15:30:13 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Network speed Linux-2.6.10
Date: Tue, 1 Mar 2005 20:30:07 +0000 (UTC)
Organization: Cistron
Message-ID: <d02jcf$ci6$1@news.cistron.nl>
References: <Pine.LNX.4.61.0503011426180.578@chaos.analogic.com> <4224CE98.2060204@candelatech.com> <1109708691.14272.8.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1109709007 12870 194.109.0.112 (1 Mar 2005 20:30:07 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@cistron.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1109708691.14272.8.camel@mindpipe>,
Lee Revell  <rlrevell@joe-job.com> wrote:
>On Tue, 2005-03-01 at 12:20 -0800, Ben Greear wrote:
>> What happens if you just don't muck with the NIC and let it auto-negotiate
>> on it's own?
>
>This can be asking for trouble too (auto negotiation is often buggy).
>What if you hard set them both to 100/full?

If you do that you also need to force the switchports to full duplex.
Lots of switches default to half-duplex without auto-negotiation.

Mike.

