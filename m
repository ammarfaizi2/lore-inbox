Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269991AbUJNIJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269991AbUJNIJi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 04:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269994AbUJNIJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 04:09:38 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:33512 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S269991AbUJNIJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 04:09:36 -0400
Message-ID: <416E343C.70900@t-online.de>
Date: Thu, 14 Oct 2004 10:09:32 +0200
From: "Harald Dunkel" <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc4-mm1: undefined reference to `hpet_alloc'
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: rADmHyZr8eA+X7X8PM+fP1RfclwAcAo6XVQDR+DqJbZ-OZ28FATDke
X-TOI-MSGID: 644c0339-8161-4687-bdeb-0af128c857d1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,


It seems that it is possible to set CONFIG_HPET_TIMER without
setting CONFIG_HPET:

% g HPET .config
CONFIG_HPET_TIMER=y
# CONFIG_HPET is not set

AFAIR this was reported before, but obviously the problem
is still in.


Regards

Harri
