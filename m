Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbUCOMuA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 07:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbUCOMuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 07:50:00 -0500
Received: from bay14-f14.bay14.hotmail.com ([64.4.49.14]:17427 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262555AbUCOMt7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 07:49:59 -0500
X-Originating-IP: [195.178.133.42]
X-Originating-Email: [gelstat_mystery@hotmail.com]
From: "dick morales" <gelstat_mystery@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: [KBUILD, FEATURE]
Date: Mon, 15 Mar 2004 04:49:57 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY14-F14t9NbbkFKJz0004f2ae@hotmail.com>
X-OriginalArrivalTime: 15 Mar 2004 12:49:57.0911 (UTC) FILETIME=[059D4A70:01C40A8C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

Many times i saw and did things like "time make bzImage modules" or "times 
..." to know
how long kernel compile process takes, many users and admins use similar 
technique.
Is it possible to add this feature to genuine kernel?
Like adding (in the top Makefile, kbuild hackers please help)
START_TIME=`date +"%s"`
END_TIME=`date +"%s"`
_TIME=$(($END_TIME-$START_TIME))
or in another form with days(anyone use 2.6 on 486 ;) ?), hours, min,sec.

And another small bug - if your locale is not posix, f.e. for non-english 
languages
UTS_ strings in linux_banner will be corrupted. Maybe set posix locale in 
Makefile,
so unpractised users will not be confused?

_________________________________________________________________
Help STOP SPAM with the new MSN 8 and get 2 months FREE*  
http://join.msn.com/?page=features/junkmail

