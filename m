Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278970AbRJ2DnU>; Sun, 28 Oct 2001 22:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278972AbRJ2DnJ>; Sun, 28 Oct 2001 22:43:09 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:63378 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S278970AbRJ2DnG>;
	Sun, 28 Oct 2001 22:43:06 -0500
Message-ID: <3BDCD06E.8AF8FF69@pobox.com>
Date: Sun, 28 Oct 2001 19:43:42 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Intel EEPro 100 with kernel drivers
In-Reply-To: <20011029021339.B23985@stud.ntnu.no>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Langås wrote:

> Hi!
>
> We've got a lot of machines with the eepro 100 from intel onboard, and when
> we try to stress-test the network (running bonnie++ on a nfs-shared
> directory on a machine), the network-card says "eth0: Card reports no
> resources" to dmesg, and then the "line" appear dead for some time (one
> minutte or more). What can be done to remove this error? NFS timesout with
> this error (obviously)...

We found that using the intel e100 driver
instead of the eepro100 eliminates these
errors - YMMV of course -

cu

jjs

