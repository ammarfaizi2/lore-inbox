Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261357AbSI2Rah>; Sun, 29 Sep 2002 13:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261362AbSI2Rah>; Sun, 29 Sep 2002 13:30:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30728 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261357AbSI2Rag>;
	Sun, 29 Sep 2002 13:30:36 -0400
Message-ID: <3D9739DF.8080704@pobox.com>
Date: Sun, 29 Sep 2002 13:35:27 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>
CC: Andi Kleen <ak@muc.de>, jbradford@dial.pipex.com,
       linux-kernel@vger.kernel.org, debian-ipv6@debian.org
Subject: Re: v2.6 vs v3.0
References: <Pine.LNX.4.44.0209291914220.18326-100000@alpha.bocc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jochen Friedrich wrote:
> So IPv6 is returned by the resolver even though IPv6 isn't available in
> the kernel. The default of the resolver options should be dependent
> on the presence or absence of IPv6 in the currently running kernel IMHO.


That sounds like glibc's problem...

glibc also has really stupid and annoying /etc/hosts behavior which 
needs fixing, and IIRC it is related to IPv6...

	Jeff



