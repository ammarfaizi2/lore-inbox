Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267196AbTAUVXR>; Tue, 21 Jan 2003 16:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267228AbTAUVXR>; Tue, 21 Jan 2003 16:23:17 -0500
Received: from fw-az.mvista.com ([65.200.49.158]:31735 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S267196AbTAUVXR>; Tue, 21 Jan 2003 16:23:17 -0500
Message-ID: <3E2DBBAD.80206@mvista.com>
Date: Tue, 21 Jan 2003 14:29:17 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joel Becker <Joel.Becker@oracle.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 32bit dev_t
References: <20030121195041.GE20972@ca-server1.us.oracle.com>
In-Reply-To: <20030121195041.GE20972@ca-server1.us.oracle.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel,

Linux doesn't really need a 32 bit kdev_t structure to support 1000 
disks.  There is plenty of device space available to support over 1500 
disks by modifying the linux scsi layer.

Thanks
-steve

Joel Becker wrote:

>Folks,
>	Who is tracking the 32bit dev_t effort for 2.5?  There are
>already existing installations with 500 to 1000 disks attached to a
>system, and I don't know that Linux really wants to wait four years to
>get there!
>	If someone could point me to a current patch or any current
>information about the issues, I'd really appreciate it.
>
>Joel
>
>  
>

