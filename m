Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261432AbSJAJkk>; Tue, 1 Oct 2002 05:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261526AbSJAJkk>; Tue, 1 Oct 2002 05:40:40 -0400
Received: from pizda.ninka.net ([216.101.162.242]:51130 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261432AbSJAJkj>;
	Tue, 1 Oct 2002 05:40:39 -0400
Date: Tue, 01 Oct 2002 02:39:08 -0700 (PDT)
Message-Id: <20021001.023908.55344393.davem@redhat.com>
To: gmitsos@telecom.ntua.gr
Cc: linux-kernel@vger.kernel.org
Subject: Re: Binary File format
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D996148.2020604@telecom.ntua.gr>
References: <3D996148.2020604@telecom.ntua.gr>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Yannis Mitsos <gmitsos@telecom.ntua.gr>
   Date: Tue, 01 Oct 2002 11:48:08 +0300
   
    From what I found until now it *seems* that we will not able to compile 
   the 2.4.x kernel. Is this true ?

There are quite a few dependencies on ELF, such as the ability to put
code/data into arbitrarily named sections.  If COFF can do this,
you're fine.

There are other dependencies on ELF, I just can't name them off the
top of my head right now.
