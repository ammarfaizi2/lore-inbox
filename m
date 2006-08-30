Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWH3POQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWH3POQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 11:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWH3POQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 11:14:16 -0400
Received: from sperry-01.control.lth.se ([130.235.83.188]:10902 "EHLO
	sperry-01.control.lth.se") by vger.kernel.org with ESMTP
	id S1751090AbWH3POP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 11:14:15 -0400
Message-ID: <44F5AB45.8030109@control.lth.se>
Date: Wed, 30 Aug 2006 17:14:13 +0200
From: Martin Ohlin <martin.ohlin@control.lth.se>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: A nice CPU resource controller
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To those interested

I have been working on a CPU resource controller using the nice value as 
a control signal. At the moment, the control is done on a 
per-task-level, but I have plans to extend it to groups of tasks. The 
control is based on a PI-controller (Proportional, Integral), using an 
execution time measurement as input to the controller, and the output 
from the controller as nice value.

Using the controller, it is possible to make CPU reservations that in a 
soft way guarante that tasks achieve as much resources as the 
corresponding reference indicates.

For those interested, the concept is described in more detail along with 
experiments in the first part of my thesis available at:
http://www.control.lth.se/database/publications/article.pike?artkey=ohlin06lic

p.s.
I changed my last name during this summer, from Andersson to Ohlin, when 
I got married. Therefore you may find references to both names in the 
thesis and elsewhere.
d.s.

/Martin
