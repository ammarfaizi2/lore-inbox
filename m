Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261619AbSJUUX0>; Mon, 21 Oct 2002 16:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261621AbSJUUX0>; Mon, 21 Oct 2002 16:23:26 -0400
Received: from pD953048C.dip.t-dialin.net ([217.83.4.140]:26632 "EHLO
	calista.inka.de") by vger.kernel.org with ESMTP id <S261619AbSJUUX0>;
	Mon, 21 Oct 2002 16:23:26 -0400
Date: Mon, 21 Oct 2002 22:29:31 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: can chroot be made safe for non-root?
Message-ID: <20021021202931.GA25035@lina.inka.de>
References: <E182ywo-0007WY-00@sites.inka.de> <200210201715.07150.landley@trommello.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210201715.07150.landley@trommello.org>
User-Agent: Mutt/1.4i
From: Bernd Eckenfels <ecki@lina.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2002 at 05:15:07PM -0500, Rob Landley wrote:
> Anything that wants to look at /etc/password or /etc/shadow comes to mind.  

only if it runs with elevated priveledges. If it is started under a users
chroot, the eleated privs come from suid/sgid.

Greetings
Bernd
