Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265960AbTBCEX4>; Sun, 2 Feb 2003 23:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265982AbTBCEX4>; Sun, 2 Feb 2003 23:23:56 -0500
Received: from rth.ninka.net ([216.101.162.244]:63435 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S265960AbTBCEXz>;
	Sun, 2 Feb 2003 23:23:55 -0500
Subject: Re: problems achieving decent throughput with latency.
From: "David S. Miller" <davem@redhat.com>
To: bert hubert <ahu@ds9a.nl>
Cc: Ben Greear <greearb@candelatech.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030202114838.GA16831@outpost.ds9a.nl>
References: <3E3CCADA.6080308@candelatech.com> 
	<20030202114838.GA16831@outpost.ds9a.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Feb 2003 21:14:53 -0800
Message-Id: <1044249293.19078.1.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

TCP can only send into a pipe as fast as it can see the
ACKs coming back.  That is how TCP clocks its sending rate,
and latency thus affects that.

