Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316770AbSHBTho>; Fri, 2 Aug 2002 15:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316912AbSHBTho>; Fri, 2 Aug 2002 15:37:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62478 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316770AbSHBThn>;
	Fri, 2 Aug 2002 15:37:43 -0400
Message-ID: <3D4AE054.6050507@mandrakesoft.com>
Date: Fri, 02 Aug 2002 15:41:08 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Austin Gonyou <austin@digitalroadkill.net>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Tigon3 support in 2.4.19-RC1 is odd.
References: <1028306594.8885.12.camel@UberGeek.coremetrics.com>
X-Enigmail-Version: 0.65.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Austin Gonyou wrote:
> The Tx Bytes and Rx Bytes counters won't seem to go beyond 4gb. Has that
> been fixed? TIA.

That's a system thing -- tx and rx bytes are 32-bit counters.  (If you 
have a 64-bit machine, then they are 64-bit counters)

	Jeff



