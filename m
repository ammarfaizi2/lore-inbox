Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280307AbRKNIGu>; Wed, 14 Nov 2001 03:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280322AbRKNIGk>; Wed, 14 Nov 2001 03:06:40 -0500
Received: from pizda.ninka.net ([216.101.162.242]:35457 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280307AbRKNIG1>;
	Wed, 14 Nov 2001 03:06:27 -0500
Date: Wed, 14 Nov 2001 00:04:56 -0800 (PST)
Message-Id: <20011114.000456.75430190.davem@redhat.com>
To: tao@acc.umu.se
Cc: bcrl@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reformat mtrr.c to conform to CodingStyle
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011114085714.V17761@khan.acc.umu.se>
In-Reply-To: <20011112232539.A14409@redhat.com>
	<20011113121022.L1778@lynx.no>
	<20011114085714.V17761@khan.acc.umu.se>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Weinehall <tao@acc.umu.se>
   Date: Wed, 14 Nov 2001 08:57:14 +0100

   I don't think Lindent does everything 100% correct; at least its
   formatting of switch/case does look a little fishy:
   
   	switch (option) {
   	case 1: 
   		/* blaha */
   
   That feels kind of odd compared to the rest of the codingstyle.

That actually looks right to me.  Look for switch statements
in the TCP code, they are layed out like that.

