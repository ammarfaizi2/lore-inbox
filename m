Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266379AbSKZPsv>; Tue, 26 Nov 2002 10:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266384AbSKZPsv>; Tue, 26 Nov 2002 10:48:51 -0500
Received: from cm61-15-171-191.hkcable.com.hk ([61.15.171.191]:35457 "EHLO
	host1.shaolinmicro.com") by vger.kernel.org with ESMTP
	id <S266379AbSKZPsv>; Tue, 26 Nov 2002 10:48:51 -0500
Message-ID: <3DE39996.9060504@shaolinmicro.com>
Date: Tue, 26 Nov 2002 23:56:06 +0800
From: David Chow <davidchow@shaolinmicro.com>
Organization: ShaoLin Microsystems Ltd.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: serial port buffer commit
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am writing a kernel thread for serial port communication. If the 
serial character device file is opened by a filp_open() or manipulating 
using a struct file in the kernel, how can I know whether the previous 
written buffer has commit or not? Similarly, how do I know is there any 
data ready for read for non blocking access? Thanks.

regards,
David Chow


