Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292399AbSBYXwz>; Mon, 25 Feb 2002 18:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292507AbSBYXwp>; Mon, 25 Feb 2002 18:52:45 -0500
Received: from c007-h014.c007.snv.cp.net ([209.228.33.221]:2204 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id <S292399AbSBYXwh>;
	Mon, 25 Feb 2002 18:52:37 -0500
X-Sent: 25 Feb 2002 23:52:31 GMT
Message-ID: <3C7ACE39.150D7D93@bigfoot.com>
Date: Mon, 25 Feb 2002 15:52:25 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.21pre2-Ole i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: cdrecord & char-major-97
In-Reply-To: <3C7AC06A.2040601@avaya.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Watterson wrote:
> 
> I am running Redhat 6.2 and cdrecord seems to be working but on
> once in awhile I see the error message: modprobe: Can't locate module
> char-major-97.
> Do you know what this means and is it serious?

Part of the cdrecord scan (see /usr/src/linux/Documentation/devices.txt,
"97 char").
Add 'alias char-major-97 off' to /etc/modules.conf if you like.

rgds,
tim.

--
