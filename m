Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268781AbUI3PZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268781AbUI3PZh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 11:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269242AbUI3PZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 11:25:36 -0400
Received: from [80.227.59.61] ([80.227.59.61]:898 "EHLO HasBox.COM")
	by vger.kernel.org with ESMTP id S268781AbUI3PZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 11:25:33 -0400
Message-ID: <415C2633.3050802@0Bits.COM>
Date: Thu, 30 Sep 2004 19:28:51 +0400
From: Mitch <Mitch@0Bits.COM>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a4) Gecko/20040928
X-Accept-Language: en-us, en, ar
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc3 software suspend (pmdisk) stopped working
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Anyone noticed that pmdisk software suspend stopped working in -rc3 ?
In -rc2 it worked just fine. My script was

  chvt 1
  echo -n shutdown >/sys/power/disk
  echo -n disk >/sys/power/state
  chvt 7

In -rc3 it appears to write pages out to disk, but never shuts down the
machine. Is there something else i need to do or am missing ?

Thanks
M
