Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264717AbUEKN3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264717AbUEKN3j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 09:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264721AbUEKN3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 09:29:39 -0400
Received: from stormdbn.stormnet.co.za ([196.22.196.1]:19156 "EHLO
	stormdbn.stormnet.co.za") by vger.kernel.org with ESMTP
	id S264717AbUEKN3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 09:29:37 -0400
Subject: weird clock problem
From: Nelis Lamprecht <nelis@brabys.co.za>
Reply-To: nelis@brabys.co.za
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Brabys Holdings
Message-Id: <1084282171.8334.46.camel@nelis.brabys.co.za>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 11 May 2004 15:29:31 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Over the past few weeks I've been having major problems keeping time on
my machine with kernel 2.6.5. At first I thought it was a problem with
ntpd but as it turns out it's my kernel.

The problem became evident while copying vast amounts of data across to
my machine. While I was copying data to it via scp my random
Xscreensaver kicked in displaying the clock and the first thing I
noticed was that the clock was advancing at a rapid rate. At the same
time I could not type anything as it would just repeat everything I
typed 10 fold. Basically the whole system behaved like it was on
steroids while I was copying to it and by the time I had finished
copying the clock was 2hrs ahead of time. With kernel 2.6.5 ntpd would
work on startup and then die saying no servers could be reached which I
assume was because my clock was so far off.

I have since downgraded to 2.6.3 and now ntpd is keeping time as it
should.

Anybody else come across this behaviour ? I'm running Gentoo on an IBM
ThinkCentre P4 3ghz. I also have APM enabled in both kernels.

Cheers,
Nelis

ps. Please CC me in on your reply as I am not subscribed.

