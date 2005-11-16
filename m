Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030460AbVKPToi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030460AbVKPToi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 14:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030464AbVKPToi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 14:44:38 -0500
Received: from 90.Red-213-97-199.staticIP.rima-tde.net ([213.97.199.90]:26735
	"HELO fargo") by vger.kernel.org with SMTP id S1030460AbVKPToh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 14:44:37 -0500
Date: Wed, 16 Nov 2005 20:44:14 +0100
From: David =?utf-8?B?R8OzbWV6?= <david@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: /net/sched/Kconfig broken
Message-ID: <20051116194414.GA14953@fargo>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

It's impossible to enable the U32 classifier in QoS submenu, to use it
with the "tc" application. In fact there are 23 :-/ options and suboptions
that are missing from the configuration because it seems that the Kconfig
file is broken.

I don't know enough Kconfig syntax, but it seems that one of the problems
is here:

config NET_CLS_ROUTE
   bool
   default n

Anyway removing this doesn't show all the options, just some of them,
so there are more problems with the net/sched/Kconfig file.


-- 
David Gómez                                      Jabber ID: davidge@jabber.org
