Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262712AbTCJEbX>; Sun, 9 Mar 2003 23:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262713AbTCJEbX>; Sun, 9 Mar 2003 23:31:23 -0500
Received: from pop.gmx.net ([213.165.64.20]:31506 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262712AbTCJEbW>;
	Sun, 9 Mar 2003 23:31:22 -0500
Message-Id: <5.2.0.9.2.20030310054319.00ceedd0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Mon, 10 Mar 2003 05:46:36 +0100
To: rwhron@earthlink.net
From: Mike Galbraith <efault@gmx.de>
Subject: Re: scheduler starvation running irman with 2.5.64bk2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030309025015.GA2843@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P.S.  You can save a little time by only running the process load.  Edit 
irman.c:412 and set load_num to 3... no need to wait for the other two 
loads to complete first, it's the process load that starves the box to 
death here.

	-Mike

