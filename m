Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266905AbUHDAkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266905AbUHDAkn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 20:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266919AbUHDAkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 20:40:42 -0400
Received: from mail001.syd.optusnet.com.au ([211.29.132.142]:63192 "EHLO
	mail001.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266905AbUHDAkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 20:40:32 -0400
Message-ID: <cone.1091580026.552226.9775.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][0/3] Scheduler policies for staircase
Date: Wed, 04 Aug 2004 10:40:26 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are not required to evaluate the staircase scheduler that is 
currently in mm2, so akpm you dont need to add these. However the users of 
the -ck patchset have been safely using the extra scheduling policies that 
these patches support. So this is for people to know they already exist and 
allow for wider testing.

The three patches that follow are:
schedrange - this makes it easier to implement more policies in code

schedbatch - this implements idle scheduling for close-to-weightless task 
scheduling which only schedules this class of task when nothing else wants 
to run. 

schediso - this implements soft real time scheduling for non-privileged 
tasks (isochronous scheduling).

patches are for 2.6.8-rc2-mm2
see each following patch for more details.

Con

