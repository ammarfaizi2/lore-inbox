Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261783AbSJNBAZ>; Sun, 13 Oct 2002 21:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261785AbSJNBAZ>; Sun, 13 Oct 2002 21:00:25 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:874 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S261783AbSJNBAY>;
	Sun, 13 Oct 2002 21:00:24 -0400
Message-ID: <3DAA1899.1030909@mvista.com>
Date: Sun, 13 Oct 2002 20:06:33 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] IPMI driver for Linux, version 6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yet one more update, mostly fixes for stylistic things that Randy Dunlap 
pointed out, and a bug fix that lets the KCS state machine get out of 
the "hosed" state on the next message (buggy hardware can sometimes be 
useful :-).  As usual, on my home page at  http://home.attbi.com/~minyard.

-Corey

PS - In case you don't know, IPMI is a standard for system management, 
it provides ways to detect the managed devices in the system and sensors 
attached to them.  You can get more information at 
http://www.intel.com/design/servers/ipmi/spec.htm


