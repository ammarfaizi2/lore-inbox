Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbSJDRL5>; Fri, 4 Oct 2002 13:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262610AbSJDRL5>; Fri, 4 Oct 2002 13:11:57 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:51158 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S262604AbSJDRL4>; Fri, 4 Oct 2002 13:11:56 -0400
Message-ID: <3D9DCD22.4070205@nortelnetworks.com>
Date: Fri, 04 Oct 2002 13:17:22 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: /proc/net/bootpc support for non-ASCII vendor specific tags?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently it appears that /proc/net/bootpc assumes that all reserved 
vendor specific tags contain ASCII information.  Is this part of the 
BOOTP standard?  I hadn't thought so, but maybe I'm missing something.

Assuming that binary information is allowable, would a patch printing 
out tags 128-254 of the vendor specific information as raw hex 
characters be considered acceptable/useful?

I need this for my own purposes, and I'm just wondering if I should 
bother trying to push it up.

Chris


