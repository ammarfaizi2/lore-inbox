Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317034AbSFWPWY>; Sun, 23 Jun 2002 11:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317035AbSFWPWX>; Sun, 23 Jun 2002 11:22:23 -0400
Received: from mta6.srv.hcvlny.cv.net ([167.206.5.17]:57806 "EHLO
	mta6.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S317034AbSFWPWX>; Sun, 23 Jun 2002 11:22:23 -0400
Date: Sun, 23 Jun 2002 11:27:41 -0400
From: sean darcy <seandarcy@hotmail.com>
Subject: Re: piggy broken in 2.5.24 build
To: Sam Ravnborg <sam@ravnborg.org>,
       linux kernel <linux-kernel@vger.kernel.org>
Message-id: <3D15E8ED.6090104@hotmail.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
References: <linux.kernel.20020623095429.A5667@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:

> 
> With your .config everything is still fine. Seems you have a problem
> on your machine. In another mail you said you had a rather large
> disk. Try to do a "df -h" to see how much space is actually available
> for the /tmp partition.
> 

> -

  df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/hde5              38G  8.9G   27G  25% /
/dev/hde2             121M  9.1M  106M   8% /boot
/dev/hde7              68G  124M   64G   1% /opt/photo/hde7
none                  219M     0  219M   0% /dev/shm
/dev/hdg1            1019M  616M  403M  61% /win/cdrive
/dev/hdg5             2.0G  1.8G  229M  89% /win/ddrive


As you can see /tmp is on the / partition. Lots of room.

jay


