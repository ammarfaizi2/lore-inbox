Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262686AbSI1CXr>; Fri, 27 Sep 2002 22:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262687AbSI1CXq>; Fri, 27 Sep 2002 22:23:46 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:46276 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S262686AbSI1CXq>;
	Fri, 27 Sep 2002 22:23:46 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200209280228.GAA02633@sex.inr.ac.ru>
Subject: Re: [PATCH] IPv6: Improvement of Source Address Selection
To: davem@redhat.com (David S. Miller)
Date: Sat, 28 Sep 2002 06:28:29 +0400 (MSD)
Cc: yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       usagi@linux-ipv6.org
In-Reply-To: <20020927.182833.66704359.davem@redhat.com> from "David S. Miller" at Sep 27, 2 06:28:33 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Otherwise I have no problems with the patch, Alexey?

I have... The implementation is bad. Source address must be retieved
from route, not running this elephant function each packet.

Alexey
