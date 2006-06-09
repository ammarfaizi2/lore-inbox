Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbWFIO5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbWFIO5y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 10:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbWFIO5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 10:57:53 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:8799 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1030192AbWFIO5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 10:57:53 -0400
Message-ID: <44898BF4.4060509@openvz.org>
Date: Fri, 09 Jun 2006 18:55:48 +0400
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: devel@openvz.org, xemul@openvz.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ebiederm@xmission.com, herbert@13thfloor.at, saw@sw.ru,
       serue@us.ibm.com, sfrench@us.ibm.com, sam@vilain.net,
       haveblue@us.ibm.com, clg@fr.ibm.com
Subject: [PATCH] IPC namespace
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patches in this thread add IPC namespace functionality
additionally to already included in -mm tree UTS namespace.

This patch set allows to unshare IPCs and have a private set
of IPC objects (sem, shm, msg) inside namespace. Basically, it is 
another building block of containers functionality.

Tested with LTP inside namespaces.

Signed-Off-By: Pavel Emelianiov <xemul@openvz.org>
Signed-Off-By: Kirill Korotaev <dev@openvz.org>

P.S. patches are against linux-2.6.17-rc6-mm1

