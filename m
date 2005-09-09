Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbVIIPCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbVIIPCx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 11:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbVIIPCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 11:02:52 -0400
Received: from smtp.dkm.cz ([62.24.64.34]:9476 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S932270AbVIIPCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 11:02:52 -0400
Message-ID: <4321A40C.6080205@rulez.cz>
Date: Fri, 09 Sep 2005 17:02:36 +0200
From: iSteve <isteve@rulez.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: query_modules syscall gone? Any replacement?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,
  I'm coding an application that messes with modules a lot, and I've 
stumbled upon a query_modules syscall in my docs. Later I've found out 
that the docs come from modutils and that module-init-tools doesn't seem 
to document (any of) the syscalls.

  May I then ask, why is the query_module syscall gone? And more 
importantly, what replaces it, if anything? It seems to me that parsing 
the /proc/modules is not only less comfortable, but according to the 
very obsolete manpage I have, it also can provide less information.

  For exmaple I'm not aware of anything like QM_SYMBOLS on per-module 
basis like it was (do correct me if I am wrong, it'd simplify my work a 
lot), ... and getting QM_REFS for example requires extensive parsing of 
/proc/modules.

Thanks in advance for reply.

  - iSteve

