Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264482AbTE1C5R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 22:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264483AbTE1C5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 22:57:17 -0400
Received: from [210.77.38.126] ([210.77.38.126]:33680 "EHLO
	ns.turbolinux.com.cn") by vger.kernel.org with ESMTP
	id S264482AbTE1C5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 22:57:16 -0400
Message-ID: <3ED4279B.1010902@turbolinux.com.cn>
Date: Wed, 28 May 2003 11:06:03 +0800
From: Qianfeng Zhang <zqfeng@turbolinux.com.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; zh-CN; rv:1.1) Gecko/20020921
X-Accept-Language: zh-cn, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: help, module dependency unresolved
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
  I am trying with the 2.5.70 beta kernel. The compiling and installing 
is OK. But
when calling "depmod -ae -b ... -F .. -r ..", the modules dependency 
and  the function
references were not resolved correctly. For example:
   in module fs/vfat/vfat.o, many functions used were exported by 
fs/fat/fat.o. But it
still complaint that the functions reference unresolved.  There is not 
similar problem with
2.4.* kernel.

  If you have met the same problem, could you let me know?

  Thanks


-- Fronteer

