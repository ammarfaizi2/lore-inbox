Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290620AbSARHkE>; Fri, 18 Jan 2002 02:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290623AbSARHjy>; Fri, 18 Jan 2002 02:39:54 -0500
Received: from pizda.ninka.net ([216.101.162.242]:40336 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290620AbSARHjh>;
	Fri, 18 Jan 2002 02:39:37 -0500
Date: Thu, 17 Jan 2002 23:38:17 -0800 (PST)
Message-Id: <20020117.233817.24612693.davem@redhat.com>
To: jason@topic.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: network connections stalls
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020118034055.GD5653@topic.com.au>
In-Reply-To: <20020118034055.GD5653@topic.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Does the "InErrs" TCP counter in /proc/net/snmp increment on the
receiver when this occurs?

It smells of bad checksumming...
