Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317024AbSHYHSS>; Sun, 25 Aug 2002 03:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317025AbSHYHSS>; Sun, 25 Aug 2002 03:18:18 -0400
Received: from pizda.ninka.net ([216.101.162.242]:31402 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317024AbSHYHSR>;
	Sun, 25 Aug 2002 03:18:17 -0400
Date: Sun, 25 Aug 2002 00:07:05 -0700 (PDT)
Message-Id: <20020825.000705.61126461.davem@redhat.com>
To: greearb@candelatech.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: packet re-ordering on SMP machines.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D6884BC.5090004@candelatech.com>
References: <3D6884BC.5090004@candelatech.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use IRQ affinity settings if you want strict packet receive ordering.
