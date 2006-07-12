Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbWGLQ6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWGLQ6d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 12:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWGLQ6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 12:58:33 -0400
Received: from smtp-out.google.com ([216.239.33.17]:26793 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751458AbWGLQ6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 12:58:32 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
	b=OTYE93A1VdEgnRwnqfeKhP279eGcv+okPj5qpEVc540dGe0VyZhyS3zpL6dRlzjbZ
	XRF1yyPdDIklvWquLeRlw==
Message-ID: <44B52A19.3020607@google.com>
Date: Wed, 12 Jul 2006 09:58:01 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>
Subject: xfs fails dbench in 2.6.18-rc1-mm1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://test.kernel.org/abat/40891/debug/test.log.1

Filesystem type for /mnt/tmp is xfs
write failed on handle 13786
4 clients started
Child failed with status 1
write failed on handle 13786
write failed on handle 13786
write failed on handle 13786

Works fine in -git4
All other fs's seemed to run OK.

Machine is a 4x Opteron.

