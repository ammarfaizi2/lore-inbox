Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313942AbSDKPgl>; Thu, 11 Apr 2002 11:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314078AbSDKPgk>; Thu, 11 Apr 2002 11:36:40 -0400
Received: from pizda.ninka.net ([216.101.162.242]:17110 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S313942AbSDKPgk>;
	Thu, 11 Apr 2002 11:36:40 -0400
Date: Thu, 11 Apr 2002 08:28:11 -0700 (PDT)
Message-Id: <20020411.082811.127950223.davem@redhat.com>
To: root@chaos.analogic.com
Cc: abraham@2d3d.co.za, linux-kernel@vger.kernel.org
Subject: Re: CHECKSUM_HW not behaving as expected
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.3.95.1020411111450.14550A-100000@chaos.analogic.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The CRC is not his problem, ipv4 will truncate it off it is
there.  In any event, see my other email, he thinks CHECKSUM_HW is
CHECKSUM_UNNECESSARY due to a bug in Rubinni's book.
