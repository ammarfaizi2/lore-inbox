Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265910AbSKBJxd>; Sat, 2 Nov 2002 04:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265916AbSKBJxd>; Sat, 2 Nov 2002 04:53:33 -0500
Received: from rth.ninka.net ([216.101.162.244]:45271 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S265910AbSKBJxc>;
	Sat, 2 Nov 2002 04:53:32 -0500
Subject: Re: [PATCH] 2.5.45 : net/ipv4/ipconfig.c
From: "David S. Miller" <davem@redhat.com>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0211020240540.856-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0211020240540.856-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Nov 2002 02:14:47 -0800
Message-Id: <1036232087.11040.0.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-01 at 23:43, Frank Davis wrote:
> Hello all,
>   The following patch moves a variable to a place prior to a label (no 
> reinitialization). Please review.

I definitely consider the existing code much cleaner, and GCC
allocated registers much more effectively when you place variables
only in the inner most scope in which they are used.

