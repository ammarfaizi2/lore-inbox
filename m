Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289853AbSAKDmh>; Thu, 10 Jan 2002 22:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289851AbSAKDm2>; Thu, 10 Jan 2002 22:42:28 -0500
Received: from zero.tech9.net ([209.61.188.187]:31501 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S289470AbSAKDmO>;
	Thu, 10 Jan 2002 22:42:14 -0500
Subject: Re: eth0: entered promiscuous mode
From: Robert Love <rml@tech9.net>
To: Balazs Javor <jb3@freemail.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020110205946.GB24838@zhadum.bjavor.d2g.com>
In-Reply-To: <20020110205946.GB24838@zhadum.bjavor.d2g.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 10 Jan 2002 22:44:46 -0500
Message-Id: <1010720687.813.5.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-10 at 15:59, Balazs Javor wrote:

> Can somebody please tell me what the above message means?
> 
> I very often encounter this in the syslog and sometimes
> also on the console.

Promiscuous mode means the network card will snag packets even if they
are not delivered to you.  Typically, only ethernet frames whose MAC
address matches you or broadcast are processed by the NIC.  Thus, your
NIC can read any and all packets on your network.

Are you sniffing your coworkers or something ? ;)

	Robert Love

