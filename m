Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265021AbUEYSHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265021AbUEYSHo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 14:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265005AbUEYSHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 14:07:44 -0400
Received: from mail.tmr.com ([216.238.38.203]:3848 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S265021AbUEYSF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 14:05:59 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: [2.6.7-rc1] BUG: ibmasm doesn't compile
Date: Tue, 25 May 2004 14:08:35 -0400
Organization: TMR Associates, Inc
Message-ID: <c901ne$4f9$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1085508142 4585 192.168.12.100 (25 May 2004 18:02:22 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually the ibmasm driver (driver->misc->ibmasm) hasn't compiled in 
some versions. However, it will compile as a module, so at the expecse 
of having all the stuff to do modules you can use it. Given the size of 
the machines which use that hardware, that's hardly an issue ;-) But not 
compiling built-in indicates a problem.

Does anyone know if there will be a driver for the current hardware? The 
one in 2.6.recent can see an RSA-I card, but doesn't seem to speak to 
the RSA-II card, which is required for security.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
