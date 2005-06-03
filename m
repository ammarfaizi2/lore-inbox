Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVFCHCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVFCHCD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 03:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVFCHCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 03:02:03 -0400
Received: from mail.avantwave.com ([210.17.210.210]:6852 "EHLO
	mail.avantwave.com") by vger.kernel.org with ESMTP id S261155AbVFCHCB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 03:02:01 -0400
Message-ID: <42A00065.9060201@avantwave.com>
Date: Fri, 03 Jun 2005 15:01:57 +0800
From: Tomko <tomko@avantwave.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: question why need open /dev/console in init() when starting kernel
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

Do anyone know why it need to open("/dev/console"....) at the end of the 
init() before calling execve("/sbin/init") ? Why open this for the in , 
out , err channel at this moment but not open it at the time when going 
to use , e.g. open it in the shell .

Regards,
TOM
