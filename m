Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289867AbSAWPUs>; Wed, 23 Jan 2002 10:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289872AbSAWPUi>; Wed, 23 Jan 2002 10:20:38 -0500
Received: from pizda.ninka.net ([216.101.162.242]:64640 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289867AbSAWPUa>;
	Wed, 23 Jan 2002 10:20:30 -0500
Date: Wed, 23 Jan 2002 07:18:55 -0800 (PST)
Message-Id: <20020123.071855.13775376.davem@redhat.com>
To: rmk@arm.linux.org.uk
Cc: davej@suse.de, martin.macok@underground.cz, linux-kernel@vger.kernel.org,
        ak@muc.de
Subject: Re: [andrewg@tasmail.com: remote memory reading through tcp/icmp]
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020121144404.B11489@flint.arm.linux.org.uk>
In-Reply-To: <20020121031211.B29830@suse.de>
	<20020120.184318.13746427.davem@redhat.com>
	<20020121144404.B11489@flint.arm.linux.org.uk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Russell King <rmk@arm.linux.org.uk>
   Date: Mon, 21 Jan 2002 14:44:04 +0000
   
   It appears that net/ipv6/ndisc.c forgets to convert the payload_len header
   field to host byteorder before comparing it.
   
   The following patch corrects this.

Applied, thanks.
