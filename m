Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317717AbSG0BHp>; Fri, 26 Jul 2002 21:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317831AbSG0BHp>; Fri, 26 Jul 2002 21:07:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:35279 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317717AbSG0BHp>;
	Fri, 26 Jul 2002 21:07:45 -0400
Date: Fri, 26 Jul 2002 17:59:55 -0700 (PDT)
Message-Id: <20020726.175955.113709567.davem@redhat.com>
To: bhaveshd@earth.dr.avaya.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.18 IPv4/devinet enhancements for down'ing
 interfaces
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0207261559380.2616-100000@earth.dr.avaya.com>
References: <Pine.LNX.4.21.0207261559380.2616-100000@earth.dr.avaya.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


IFF_NOARP is a deprecated 2.2.x feature for normal interfaces and is
no longer used in 2.4.x and later.

The only reason IFF_NOARP still exists in the current code is to
handle some tunneling issues.
