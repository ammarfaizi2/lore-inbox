Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317667AbSGOTs7>; Mon, 15 Jul 2002 15:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317668AbSGOTs6>; Mon, 15 Jul 2002 15:48:58 -0400
Received: from [209.184.141.189] ([209.184.141.189]:2077 "HELO UberGeek")
	by vger.kernel.org with SMTP id <S317667AbSGOTs4>;
	Mon, 15 Jul 2002 15:48:56 -0400
Subject: sysctl parameter tuning part deux.
From: Austin Gonyou <austin@digitalroadkill.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 15 Jul 2002 14:51:45 -0500
Message-Id: <1026762705.14226.11.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to include a url in my last email. Sorry about that. 

Here is the document I was working from:
http://www.tldp.org/LDP/solrhe/Securing-Optimizing-Linux-RH-Edition-v1.3/chap6sec72.html

one point about this in particular is the fact that this document
recommends 256 FDs for every 4M ram. I'm running a Dell 6650 with 8GB
RAM, and well, adhering to this would mean I must allocate ~500M FDs. 

That seems too high for *proper* operation to me. Is there a better
method to use?
-- 
Austin Gonyou <austin@digitalroadkill.net>
