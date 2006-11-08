Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161372AbWKHRqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161372AbWKHRqM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 12:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754622AbWKHRqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 12:46:12 -0500
Received: from wr-out-0506.google.com ([64.233.184.234]:23158 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1754616AbWKHRqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 12:46:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:user-agent:date:from:to:cc:subject:message-id;
        b=WeM1SMOnxHCMWOBK4drMKmYziWFmrOmszZ7/WGaS3wwyMBVOsFCXdSdlKPhnE6rFbNUbkGv+jSaqIpZ9QGf566pSJvG5iUYcDgsYij8uRkLYqYw+SGb3tgt66DzZFqz9S+7c1f/0l+VhEp5UVIcNqL74TSmTw4DQpGSPoT7QhnM=
User-Agent: quilt/0.45-1
Date: Thu, 09 Nov 2006 02:45:41 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, Don Mullis <dwm@meer.net>
Subject: [patch 0/7] Fault-injection capabilities (v6)
Message-ID: <455217df.719dec4f.2c80.ffffb500@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fault-injection capabilities patch set version 6.
Please read the mail for the patch 1/7 for details

Changes from the last version

- add /debug/{failslab,fail_page_alloc}/ignore-gfp-highmem
  to let fault-injector ignore highmem/user allocations

- add /debug/{failslab,fail_page_alloc}/ignore-gfp-wait
  to let fault-injector ignore sleepable allocations.

- use random32() for lightweight random simlator

- update documentation and scripts

