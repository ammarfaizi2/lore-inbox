Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbVLALp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbVLALp1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 06:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbVLALp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 06:45:27 -0500
Received: from www.stv.ee ([212.7.5.251]:59407 "EHLO www.stv.ee")
	by vger.kernel.org with ESMTP id S932174AbVLALp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 06:45:27 -0500
Message-ID: <438EE256.6040403@tuleriit.ee>
Date: Thu, 01 Dec 2005 13:45:26 +0200
From: Indrek Kruusa <indrek.kruusa@tuleriit.ee>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [QUESTION] Filesystem like structure in RAM w/o using filesystem
 (not ramdisk)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

As I have understood the accessing ramdisk goes through the same kernel 
path which is meant for accessing slow block device (i_nodes caching etc.).
Is there any other common way (some API above shared memory?) to 
create/open/read/write globally accessible hierarchical datablocks in RAM?
Could it be possibly faster than ramdisk?

Thanks in advance,
Indrek

