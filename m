Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbTIBVel (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 17:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbTIBVek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 17:34:40 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:61625 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S261604AbTIBVei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 17:34:38 -0400
Date: Tue, 2 Sep 2003 17:29:43 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Russell Whitaker <russ@ashlandhome.net>
cc: Adrian Bunk <bunk@fs.tum.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0: module char_10_135
In-Reply-To: <Pine.LNX.4.53.0308301123170.468@bigred.russwhit.org>
Message-ID: <Pine.GSO.4.33.0309021727440.13584-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Aug 2003, Russell Whitaker wrote:
>module-init-tools 0.9.13-pre 2
>
>That was the latest version I could find on Aug 3rd. Please let me know
>if there is a later version I should try.

Check the order of calls during boot.  In most cases, the rtc will be
required before modules are setup -- /proc/sys/kernel/modprobe isn't
set yet.

--Ricky


