Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbUBNMw3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 07:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbUBNMw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 07:52:29 -0500
Received: from shells.hardanger.net ([209.113.172.35]:60945 "EHLO
	server.bohemians.org") by vger.kernel.org with ESMTP
	id S261881AbUBNMw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 07:52:28 -0500
Date: Sat, 14 Feb 2004 07:52:22 -0500
From: Kristian =?iso-8859-1?Q?Lyngst=F8l?= <nesquik@bohemians.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: 8139too + e1000 weirdness
Message-ID: <20040214125222.GA6293@bohemians.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings

I just removed my old 8139too card, upgraded to 2.6.2 and inserted a
Intel PRO 1000 Desktop MT card (e1000)... I did however forget to
remove 8139too from /etc/modules, so naturally it got modprobed
on boot... and loaded. Shouldn't it see that it doesn't have a 
8139too card anymore? That sure is what I'm used to...

It did not show up on ifconfig, but it did however create a
strange effect which resulted in that I didn't get contact
with my gateway (ping or otherwise...) but all other machines
I tried (all though this wasn't many...). The problem resolved it
self when I rmmoded 8139too...

.config files and whatever more you need on request 

-- 
Regards
Kristian Lyngstøl
