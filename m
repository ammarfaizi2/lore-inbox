Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267933AbRGXQfL>; Tue, 24 Jul 2001 12:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267931AbRGXQev>; Tue, 24 Jul 2001 12:34:51 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:34468 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S267928AbRGXQen>; Tue, 24 Jul 2001 12:34:43 -0400
Date: Tue, 24 Jul 2001 18:34:48 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: "Antwerpen, Oliver" <Antwerpen@netsquare.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udp-broadcast
Message-ID: <20010724183448.H750@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <9DD550E9A9B0D411A16700D0B7E38BA4515130@POL-EML-SRV1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <9DD550E9A9B0D411A16700D0B7E38BA4515130@POL-EML-SRV1>; from Antwerpen@netsquare.org on Tue, Jul 24, 2001 at 05:00:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 24, 2001 at 05:00:45PM +0200, Antwerpen, Oliver wrote:
> Moin!
> 
>   ret = setsockopt(my_socket, IPPROTO_UDP, SO_BROADCAST, (void *)&flag,
> sizeof(flag) );

Try setsockopt(tx_socket,SOL_SOCKET,SO_BROADCAST,..).

And use an actual broadcast-address as sender.

HTH & Regards

Ingo Oeser
-- 
Use ReiserFS to get a faster fsck and Ext2 to fsck slowly and gently.
