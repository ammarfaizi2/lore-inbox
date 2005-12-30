Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbVL3OaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbVL3OaM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 09:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbVL3OaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 09:30:12 -0500
Received: from main.gmane.org ([80.91.229.2]:32726 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932150AbVL3OaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 09:30:10 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: jared <demottjar@yahoo.com>
Subject: Why doesn't my system have the core_setuid_ok key?
Date: Fri, 30 Dec 2005 09:19:26 -0500
Message-ID: <dp3fot$6df$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-11-54-76.hsd1.mi.comcast.net
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all:

I'm running the postfix mailing system and made a few modifications. 
It's dieing with signal 11 but not dumping core -- and I need a core 
dump.  I asked on the postfix group how to deal with this but they said 
I need to come talk to a linux group.  They said the reason is because 
my system will not let a process that starts life as root (but than 
drops privs) to dump core.  They said I need to check my 
kernel.core_setuid_ok key, but my systems don't have that key.  (I have 
redhat (2.4.20) and FC (2.6.12))

I've also already modified the /etc/security/limits and /etc/profile to 
allow system wide cores.

Can anyone shed some light on my attempts to get cores?

Thanks,
Jared DeMott

