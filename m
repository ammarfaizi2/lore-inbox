Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129833AbRCGB7X>; Tue, 6 Mar 2001 20:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129854AbRCGB7N>; Tue, 6 Mar 2001 20:59:13 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:39236 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129833AbRCGB7B>; Tue, 6 Mar 2001 20:59:01 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: jdthood@mail.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Forcible removal of modules 
In-Reply-To: Your message of "Tue, 06 Mar 2001 14:17:28 -0800."
             <9038100.983917051702.JavaMail.imail@digger.excite.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 07 Mar 2001 12:58:11 +1100
Message-ID: <7691.983930291@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2001 14:17:28 -0800 (PST), 
Thomas Hood <thood@excite.com> wrote:
>My question is: Is there some better way of blocking 
>all open() calls to a particular device driver while
>processes using it are being killed off?

Not yet.  There have been some off list discussions about redoing the
module load/unload process to avoid races, as part of that we will get
forced module unregister followed by unload when the use count goes to
zero.  Probably 2.5 changes.

