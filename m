Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264545AbTL0TiY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 14:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbTL0TiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 14:38:24 -0500
Received: from dirac.phys.uwm.edu ([129.89.57.19]:28862 "EHLO
	dirac.phys.uwm.edu") by vger.kernel.org with ESMTP id S264559AbTL0TiW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 14:38:22 -0500
Date: Sat, 27 Dec 2003 13:38:08 -0600 (CST)
From: Bruce Allen <ballen@gravity.phys.uwm.edu>
To: Carlo <devel@integra-sc.it>
cc: dan carpenter <error27@email.com>, Oleg Drokin <green@linuxhacker.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: Ooops with kernel 2.4.22 and reiserfs
In-Reply-To: <1072529558.21200.111.camel@atena>
Message-ID: <Pine.GSO.4.21.0312271335550.10175-100000@dirac.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Run some drive self-tests:
> >    smartctl -t long /dev/hda
> > and let them complete, then look again at
> >    smartctl -a /dev/hda
> > 
> smartctl version 5.26 Copyright (C) 2002-3 Bruce Allen
> Home page is http://smartmontools.sourceforge.net/
>                                                                                                  
> === START OF INFORMATION SECTION ===
> Device Model:     Maxtor 6Y120L0
> Serial Number:    Y3K9Q2GE
> Firmware Version: YAR41BW0

<snip>

> SMART Error Log Version: 1
> No Errors Logged
>                                                                                                  
> SMART Self-test log structure revision number 1
> Num  Test_Description    Status                  Remaining 
> LifeTime(hours)  LBA_of_first_error
> # 1  Extended offline    Completed without error       00%      
> 997         -
>                                                                                                  
> Some ideas??

The only contribution I can make to this discussion is to suggest that
'your problem is not due to the drive': it doesn't exhibit any of the
symptoms of a sick Maxtor disk.

Bruce

