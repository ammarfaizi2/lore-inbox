Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161109AbVKDC3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161109AbVKDC3u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 21:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161116AbVKDC3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 21:29:49 -0500
Received: from smtp-out.google.com ([216.239.45.12]:54023 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1161109AbVKDC3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 21:29:49 -0500
Message-ID: <436AC790.9030901@google.com>
Date: Thu, 03 Nov 2005 18:29:36 -0800
From: =?UTF-8?B?IkFydW4gU2hhcm1hICjgpIXgpLDgpYHgpKMpIg==?= 
	<arun.sharma@google.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: rohit.seth@intel.com
Subject: IPC_STAT and SHM_HUGETLB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If one process creates a shared memory segment with SHM_HUGETLB, how can 
another process find out if the shmid corresponds to a hugetlb page?

IPC_STAT doesn't seem to return anything that says the segment is made 
up of hugetlb pages.

	-Arun

