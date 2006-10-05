Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751492AbWJEFhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbWJEFhO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 01:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWJEFhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 01:37:14 -0400
Received: from smtp-out.google.com ([216.239.45.12]:14123 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751490AbWJEFhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 01:37:13 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:mime-version:to:
	subject:content-type:content-transfer-encoding;
	b=Xmv5lZMxprMzIWAmm3jssKGDHMLlbLW2y9HudijD3RXhjbk49EwYhKdFMQXubD/04
	OJdEf9l0QKjBUJTT/7kzw==
Message-ID: <452499AA.6060103@google.com>
Date: Wed, 04 Oct 2006 22:35:38 -0700
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.18 LTP failures
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sched_setscheduler02    1  FAIL  :  sched_setscheduler(2) passed with 
non root priveledges
sysfs01     1  FAIL  :  sysfs(2) Failed for option 1 and set errno to 22


To be fair, I have no idea if these are failures in LTP itself or
2.6.18, but thought I'd mention them. On the upside, we seem to have
way less failures than we used too (mostly LTP problems, used to be)
LTP version is 20060918

M.
