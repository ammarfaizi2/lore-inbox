Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287950AbSATEbF>; Sat, 19 Jan 2002 23:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287948AbSATEa4>; Sat, 19 Jan 2002 23:30:56 -0500
Received: from femail23.sdc1.sfba.home.com ([24.0.95.148]:9443 "EHLO
	femail23.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S287950AbSATEah>; Sat, 19 Jan 2002 23:30:37 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>,
        Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Subject: Re: rm-ing files with open file descriptors
Date: Sat, 19 Jan 2002 15:26:26 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0201191030490.23101-100000@filesrv1.baby-dragons.com>
In-Reply-To: <Pine.LNX.4.44.0201191030490.23101-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020120043037.TXUX9511.femail23.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 January 2002 10:32 am, Mr. James W. Laferriere wrote:

> > This is a possible security risk: The unlinking program thinks the file
> > is forever inaccessible, but it isn't...
>
> 	Will the ability to access this linked file still be there  across
> 	a reboot ?  Or an fsck ?  Tia ,  JimL

Actually deleting files with a link count of zero is one of the things fsck 
is for, I believe...

Rob
