Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSHLUVE>; Mon, 12 Aug 2002 16:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311025AbSHLUVE>; Mon, 12 Aug 2002 16:21:04 -0400
Received: from pD952ADBE.dip.t-dialin.net ([217.82.173.190]:7085 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S310190AbSHLUVE>; Mon, 12 Aug 2002 16:21:04 -0400
Date: Mon, 12 Aug 2002 14:24:27 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: "David S. Miller" <davem@redhat.com>
cc: davids@webmaster.com, <jroland@roland.net>, <Hell.Surfers@cwctv.net>,
       <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: The spam problem.
In-Reply-To: <20020812.005022.69048367.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0208121415450.4518-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 12 Aug 2002, David S. Miller wrote:
> If you enforce that the first sender at the Received: headers
> have to match the From: or some rule like that, then I could
> not post to these lists for example.

This is quite a bad idea.

If we go after the hostname, things like Puretec or our Hawkeye will be 
shot. Imagine the domain ngforever.de. It's hosted on kundenserver.de, and 
the smtp host is smtp.kundenserver.de. How can we guess?!

If we go after MX entries, most people will be shot. T-Online, Yahoo, 
Netscape... all have different smarthosts for users and incoming mail. 
T-Online, for example, has mailin00 through mailin07.sul.t-online.de for 
the incoming messages, while users use fwd00 through 
fwd07.sul.t-online.com in order to send mail.

We'll break things either way. I send mail via hawkeye.lightweight.adm 
(not an internet address, but the realname, and yes, it's a large 
network.) for the domain lightweight.ods.org, where's the connection? In 
order to find out that hawkeye.lightweight.adm is the mail host of 
lightweight.ods.org you'll have to ask a domain server on our side. 
However, Hawkeye signs things with his realname.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

