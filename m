Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262642AbVCJBzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbVCJBzr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262604AbVCJBzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:55:20 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:48012 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262444AbVCJBvb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 20:51:31 -0500
Message-ID: <422FA817.4060400@ca.ibm.com>
Date: Wed, 09 Mar 2005 19:51:19 -0600
From: Omkhar Arasaratnam <iamroot@ca.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: tgall@us.ibm.com, antonb@au1.ibm.com
Subject: [BUG] 2.6.11- sym53c8xx Broken on pp64
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems with 2.6.11 the sym53c8xx kernel module incorrectly identifies the
cache being misconfigured on a p630 (ppc64, POWER4+). 2.6.9 correctly
brings up this adaptor as does AIX with absolutely no indication of a
misconfigured cache.

Doing a simple diff I see ALOT of changes between 2.6.9 and 2.6.11
pertaining to this module. Any ideas?

O

