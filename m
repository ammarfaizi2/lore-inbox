Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264827AbSJPC4q>; Tue, 15 Oct 2002 22:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264831AbSJPC4q>; Tue, 15 Oct 2002 22:56:46 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:9071 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S264827AbSJPC4p>;
	Tue, 15 Oct 2002 22:56:45 -0400
Message-ID: <3DACD6E3.6020707@mvista.com>
Date: Tue, 15 Oct 2002 22:02:59 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] IPMI driver for Linux, version 7
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the continuing saga of IPMI driver updates, here's another installment.

More cleanups and bug fixes, some from Arjan van de Ven, and others from 
myself. This fixes some problems with blocking operations while holding 
a lock. It has an unfortunate interface change (but better now than 
later), the lun field is removed from the IPMI message, and one is added 
to the system interface address. It's a minor change, but it really 
needed to be done to make things consistent. It's only released as a 
patch to the v6 version and it applies cleanly to all kernel versions. 
 As usual, you can download the driver from my home page at  
http://home.attbi.com/~minyard.

-Corey

PS - In case you don't know, IPMI is a standard for system management, 
it provides ways to detect the managed devices in the system and sensors 
attached to them.  You can get more information at 
http://www.intel.com/design/servers/ipmi/spec.htm

