Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbTIYNYP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 09:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbTIYNYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 09:24:15 -0400
Received: from dsl-212-23-25-139.zen.co.uk ([212.23.25.139]:15836 "EHLO
	butternut.transitive.com") by vger.kernel.org with ESMTP
	id S261186AbTIYNYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 09:24:14 -0400
Message-ID: <3F72EC23.6070403@treblig.org>
Date: Thu, 25 Sep 2003 14:22:43 +0100
From: "Dave Gilbert (Home)" <gilbertd@treblig.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Norris, Brent" <bnorris@Edmonson.k12.ky.us>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: 128G Limit in Reiserfs? Or the Kernel? Or something else?
References: <9A8F8D67DC8ED311BF3E0008C7B9A0ADBAA86E@E151000N0>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-TL-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norris, Brent wrote:
> I seem to have hit an odd limit, that I didn't think existed.  I have a 250G
> WD IDE hard drive that I have just installed.  Since I couldn't put a Ext3
> filesystem on it (mount wouldn't recognize it) I decided to put a ReiserFS
> filesystem on it.  Since I have done that I have added 128G of data to the
> drive.  Now when I attempt to copy more data to it I get an error that there
> is no more space on the drive.

Reiser can definitly do larger file systems than that (I have a Reiser 
file system with over 300GB on).

Its worth trying a df -i to make sure you haven't run out of inodes - 
but then you say you can create empty files.

Dave

