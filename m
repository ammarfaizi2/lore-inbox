Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293085AbSCEMsW>; Tue, 5 Mar 2002 07:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293094AbSCEMsC>; Tue, 5 Mar 2002 07:48:02 -0500
Received: from pizda.ninka.net ([216.101.162.242]:21633 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293082AbSCEMr4>;
	Tue, 5 Mar 2002 07:47:56 -0500
Date: Tue, 05 Mar 2002 04:45:46 -0800 (PST)
Message-Id: <20020305.044546.88470397.davem@redhat.com>
To: arnaud.giersch@free.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM+PATCH] linux 2.[45].x: negative inode numbers in
 /proc/net/*
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <871yff535c.fsf@free.fr>
In-Reply-To: <871yff535c.fsf@free.fr>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Arnaud Giersch <arnaud.giersch@free.fr>
   Date: 20 Feb 2002 21:06:39 +0100
   
   I think I found a little but annoying bug in the /proc/net reporting
   functions for various types of sockets: when the inode numbers become
   large enough, they are printed as negative values.

Thanks, I've applied your patch.
