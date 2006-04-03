Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWDCU4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWDCU4y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 16:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbWDCU4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 16:56:54 -0400
Received: from smtp-out.google.com ([216.239.45.12]:30908 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964880AbWDCU4x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 16:56:53 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
	b=g5tkDb+eEjTYltcYrqsfqyvzmpcSgJt8P0PgTFZfmWD+H1yU5EsRyuaGGO6YkR7QU
	nzx1zBP3tHjTeAjX1z2zQ==
Message-ID: <44318C0A.1060309@google.com>
Date: Mon, 03 Apr 2006 13:56:42 -0700
From: Arun Sharma <arun.sharma@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.16 error on a 8 core system
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If you already have an interesting kernel panic to chase, you can stop 
reading :)

EXT3-fs error (device sda1): ext3_free_blocks_sb: bit already cleared 
for block 16
Aborting journal on device sda1.
EXT3-fs error (device sda1) in ext3_free_blocks_sb: Journal has aborted
EXT3-fs error (device sda1) in ext3_free_blocks_sb: Journal has aborted
EXT3-fs error (device sda1) in ext3_free_blocks_sb: Journal has aborted
EXT3-fs error (device sda1) in ext3_free_blocks_sb: Journal has aborted

It could be a hardware issue or a kernel issue. If you have any insights 
into how this can happen, please drop me a line.

	-Arun
