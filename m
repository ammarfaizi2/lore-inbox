Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263836AbUA0PDe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 10:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263946AbUA0PDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 10:03:34 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:9942 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S263836AbUA0PDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 10:03:33 -0500
Message-ID: <40167DCA.7040006@myrealbox.com>
Date: Tue, 27 Jan 2004 07:03:38 -0800
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040125
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: ACPI versus VIA IDE controller?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know there has been a problem getting the VIA ide controller
to cooperate with ACPI, but I saw a bunch of acpi changes coming
from Linus today so I reenabled acpi in my 2.6.2-rc2 again just
out of curiosity.

I still see the message about the VIA ide controller:
ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1 -
using IRQ 255

I haven't exercised the machine much, but it all seems to be
working just fine so far.

Are there any known risks to running the machine in this mode?
