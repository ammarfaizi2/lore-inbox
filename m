Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161007AbWBYPas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161007AbWBYPas (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 10:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161009AbWBYPas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 10:30:48 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:39393 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1161007AbWBYPar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 10:30:47 -0500
Date: Sat, 25 Feb 2006 16:30:38 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: creating live virtual files by concatenation
In-Reply-To: <1271316508.20060225153749@dns.toxicfilms.tv>
Message-ID: <Pine.LNX.4.61.0602251629560.13355@yvahk01.tjqt.qr>
References: <1271316508.20060225153749@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Now let us say I am creating sort of a virtual text file (code.js)
>that is a live-concatenation of these files:
># concatenate tooltip.js banner.js foo.js code.js
>
>Note I am not talking about the cat(1) utility. I am thinking of
>code.js be always a live concatenated version of these three, so when
>I modify one file, the live-version is also modified.
>
>What puprose I might have? Network-related. Say, I have an HTML file
>that includes these three files in its code.
>
Try FUSE.

>If I had a live-concatenated file, I could reference it in the HTML file
>so that the browser does not have to download three files but just one.
>
>This would surely reduce network overhead of downloading the same amount
>of data but within just one connection, reduce resource usage on the client
>and possibly (depending on implementation) reduce the cost of accessing
>three individual files on the server.
>
Have you ever heard of persistent connections with HTTP/1.1?


Jan Engelhardt
-- 
