Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264585AbUHBOzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264585AbUHBOzG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 10:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUHBOzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 10:55:06 -0400
Received: from main.gmane.org ([80.91.224.249]:22703 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264585AbUHBOyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 10:54:50 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: OLS and console rearchitecture
Date: Mon, 02 Aug 2004 20:54:34 +0600
Message-ID: <410E55AA.8030709@ums.usu.ru>
References: <20040802142416.37019.qmail@web14923.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dsa.physics.usu.ru
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
In-Reply-To: <20040802142416.37019.qmail@web14923.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> 15) Over time user space console will be moved to a model where VT's
> are implemented in user space. This allows user space console access to
> fully accelerated drawing libraries. This might allow removal of all of
> the tty/vc layer code avoiding the need to fix it for SMP.

One more minor problem. We need to ensure somehow that the "killall5" 
program from the sysvinit package will not kill our userspace console 
daemon at shutdown (got this when I tried to put fbiterm into 
initramfs). What is the best way to achieve that?

-- 
Alexander E. Patrakov

