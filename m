Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268058AbUI1VtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268058AbUI1VtT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 17:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268052AbUI1Vs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 17:48:58 -0400
Received: from smtp1.netcabo.pt ([212.113.174.28]:35951 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S268049AbUI1Vsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 17:48:55 -0400
Message-ID: <32901.192.168.1.5.1096408010.squirrel@192.168.1.5>
In-Reply-To: <32791.192.168.1.5.1096405439.squirrel@192.168.1.5>
References: <1094683020.1362.219.camel@krustophenia.net>      
    <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu>      
    <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu>      
    <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu>      
    <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu>      
    <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu>   
    <32798.192.168.1.5.1096402672.squirrel@192.168.1.5>
    <32791.192.168.1.5.1096405439.squirrel@192.168.1.5>
Date: Tue, 28 Sep 2004 22:46:50 +0100 (WEST)
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm4-S7
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       "K.R. Foley" <kr@cybsft.com>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 28 Sep 2004 21:48:53.0780 (UTC) FILETIME=[F2AC1540:01C4A5A4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is another quirk on -mm4 I have found: I have a couple of outsider
modules, both related to webcams, that fail on modprobe wrt same missing
kernel symbol:

w9968cf: Unknown symbol remap_page_range
spca50x: Unknown symbol remap_page_range

CU
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

