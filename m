Return-Path: <linux-kernel-owner+w=401wt.eu-S932831AbWL0OQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932831AbWL0OQa (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 09:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932857AbWL0OQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 09:16:30 -0500
Received: from web32603.mail.mud.yahoo.com ([68.142.207.230]:45239 "HELO
	web32603.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932831AbWL0OQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 09:16:29 -0500
X-YMail-OSG: 9Hg93P4VM1n7rXQ9WSjkSelfKl74LIjo_CyVCKC_8VeU_K.tnn4J3J_wFsh3Wji1NowQKLeeqzrLn.YdeDIIvcsJ_V9d9FYcL3AyPniVbZEFPcqhbU7sUw--
X-RocketYMMF: knobi.rm
Date: Wed, 27 Dec 2006 06:16:27 -0800 (PST)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: How to detect multi-core and/or HT-enabled CPUs in 2.4.x and 2.6.x kernels
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <666716.84435.qm@web32603.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, (please CC on replies, thanks)

 for the ganglia project (http://ganglia.sourceforge.net/) we are
trying to find a heuristics to determine the number of physical CPU
"cores" as opposed to virtual processors added by enabling HT. The
method should work on 2.4 and 2.6 kernels.

 So far it seems that looking at the "physical id", "core id" and "cpu
cores" of /proc/cpuinfo is the way to go.

 In 2.6 I would try to find the  distinct "physical id"s and  and sum
up the corresponding "cpu cores". The question is whether this would
work for 2.4 based systems.

 Does anybody recall when the "physical id", "core id" and "cpu cores"
were added to /proc/cpuinfo ?

Cheers
Martin

------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
