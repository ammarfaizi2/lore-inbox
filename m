Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262220AbUKDNg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbUKDNg1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 08:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbUKDNg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 08:36:27 -0500
Received: from imap.gmx.net ([213.165.64.20]:44523 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262220AbUKDNgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 08:36:12 -0500
X-Authenticated: #21910825
Message-ID: <418A303E.1050709@gmx.net>
Date: Thu, 04 Nov 2004 14:35:58 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6) Gecko/20040114
X-Accept-Language: de, en
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: boot option for CONFIG_EDD_SKIP_MBR?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

[please CC: me on replies]
having had problems (inifinte hang on boot) with some Fujitsu
Siemens Scenic computers when EDD was enabled, I asked myself
if it would be possible to add a boot option edd=nombr and
possibly also another boot option edd=off to the EDD code in
the kernel. These would correspond to CONFIG_EDD_SKIP_MBR
and CONFIG_EDD, respectively.
That way, distributors could use the benefits of enabled
EDD on working machines and provide customers with the
ability to switch off EDD on broken machines, all with the
same kernel.
Yes, option parsing before entering protected mode is ugly,
but the vga setup code does it, too.

What do you think?

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
