Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161826AbWKOWDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161826AbWKOWDH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 17:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161821AbWKOWDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 17:03:07 -0500
Received: from smtp-out.neti.ee ([194.126.126.45]:46037 "EHLO smtp-out.neti.ee")
	by vger.kernel.org with ESMTP id S1161824AbWKOWDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 17:03:05 -0500
From: Hasso Tepper <hasso@estpak.ee>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Sysctl syscall
Date: Thu, 16 Nov 2006 00:03:02 +0200
User-Agent: KMail/1.9.4
Organization: Elion Enterprises Ltd.
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611160003.02681.hasso@estpak.ee>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling the program which uses a lot "sysctl" syscalls, gives me this 
warning on Debian unstable:

"warning: the `sysctl' syscall has been removed from 2.6.18+ kernels, 
direct access to `/proc/sys' should be used instead."

Is it true? And what can be used as alternative which would work with both 
2.4 and 2.6 kernels and would work with capabilities (sys/capability.h)?
Accessing `/proc/sys' directly isn't such alternative as it doesn't work 
with capabilities.


regards,

-- 
Hasso Tepper
Elion Enterprises Ltd. [AS3249]
Data Communication Network Administrator
