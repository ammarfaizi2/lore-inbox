Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbTEFLM3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 07:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbTEFLM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 07:12:29 -0400
Received: from moutng.kundenserver.de ([212.227.126.185]:27847 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262547AbTEFLM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 07:12:27 -0400
Message-ID: <3EB79C0E.5060608@onlinehome.de>
Date: Tue, 06 May 2003 13:27:10 +0200
From: Hans-Georg Thien <1682-600@onlinehome.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: wwp <subscript@free.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] "Disable Trackpad while typing" on Notebooks withh
 a PS/2 Trackpad
References: <3EB19625.6040904@onlinehome.de> <20030506112928.60306baf.subscript@free.fr>
In-Reply-To: <20030506112928.60306baf.subscript@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wwp wrote:
> Hi Hans-Georg Thien,
> 
> 
> Would it be possible to enable/disable this feature from userspace using an
> echo 1 > /proc/blabla, or only using insmod/modprobe -r?
> Anyway, very good idea!
> 
> 
I'm working on an "echo ??? >/proc/something?" solution, where ??? is

delay=1200 # adjust trackpad to delay 1200 mSec after last keystroke
delay=0    # no delay, => disable that feature


-Hans


