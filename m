Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261866AbTCQSpy>; Mon, 17 Mar 2003 13:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261867AbTCQSpy>; Mon, 17 Mar 2003 13:45:54 -0500
Received: from air-2.osdl.org ([65.172.181.6]:19680 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261866AbTCQSpx>;
	Mon, 17 Mar 2003 13:45:53 -0500
Date: Mon, 17 Mar 2003 10:53:36 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where did IPX on 2.5 go?
Message-Id: <20030317105336.59fd3eec.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.51.0303171939220.15852@dns.toxicfilms.tv>
References: <Pine.LNX.4.51.0303171939220.15852@dns.toxicfilms.tv>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Mar 2003 19:40:58 +0100 (CET) Maciej Soltysiak <solt@dns.toxicfilms.tv> wrote:

| Hi,
| 
| i tried to find IPX support in 2.5 via make menuconfig, it is not there.
| (or where it used to be)
| There is nothing about IPX also in .config but net/ipx files are there.
| 
| It is 2.5.64-bk12. Was it removed or i am missing something here.

Hi-

It should show up just under LLC, but you must enable LLC:

       <*> ANSI/IEEE 802.2 - aka LLC (IPX, Appletalk, Token Ring)       
       [ ]   LLC sockets interface (NEW)                                
       < >   The IPX protocol (NEW)

HTH.
--
~Randy
