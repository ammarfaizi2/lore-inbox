Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbWDYHTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWDYHTq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 03:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWDYHTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 03:19:46 -0400
Received: from mail.dgt.com.pl ([195.117.141.2]:34052 "EHLO dgt.com.pl")
	by vger.kernel.org with ESMTP id S1751301AbWDYHTp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 03:19:45 -0400
Message-ID: <444DCD8B.2000205@dgt.com.pl>
Date: Tue, 25 Apr 2006 09:19:39 +0200
From: Wojciech Kromer <wojciech.kromer@dgt.com.pl>
Reply-To: wojciech.kromer@dgt.com.pl
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Own APR resolution in 2.4 kernel module
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
I need own ARP resolution call in my module.

Now i'm using neigh_lookup.
It's pretty fast, and works fine if my entry is already in arp_tbl,
but   it doesn't send  any reqest if trere is no one.

I found  arp_solicit function, but it's not exported, and no 
documentation found.

Probably I'm not the first one with such question, but not found any 
sollution yet.

PS Please reply on my priv too.

