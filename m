Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbTFKTeS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 15:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbTFKTeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 15:34:18 -0400
Received: from d-216-195-190-132.metrocast.net ([216.195.190.132]:5671 "EHLO
	timemachine.dsbcpas.com") by vger.kernel.org with ESMTP
	id S263600AbTFKTeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 15:34:17 -0400
Message-ID: <3EE78770.2070704@dsbcpas.com>
Date: Wed, 11 Jun 2003 15:48:00 -0400
From: scott <scott@dsbcpas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.3.1) Gecko/20030425
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PATCH: dpt_i2o memory leak comments
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Question/Help:
Our threading indexer routinely crashes our Adaptec 2400A. How can I 
duplicate that activity for the Adaptec team as they request below?
Scott Beane

-------- Original Message --------
Subject: 	RE: [Fwd: Re: dpt_i2o memory leak]
Date: 	Wed, 11 Jun 2003 13:49:27 -0400
From: 	Salyzyn, Mark <mark_salyzyn@adaptec.com>
To: 	'scott' <scott@dsbcpas.com>
CC: 	'tcallawa@redhat.com' <tcallawa@redhat.com>



Thanks, I believe this confirms my understanding at least regarding the
`leak'. I will try to `make it better' in the future.

The panic you forwarded is a source of consternation. It occurs in the
scsi_done command which takes it out of the driver making it difficult of
debug (remote as we are).

Being able to duplicate this problem locally becomes necessary. If you can
provide to me a simplified set of tools and description on how to duplicate
this, I will get this sent off to our software test team to bash on.

Sincerely -- Mark Salyzyn



