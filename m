Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271066AbRHOGlq>; Wed, 15 Aug 2001 02:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271067AbRHOGlg>; Wed, 15 Aug 2001 02:41:36 -0400
Received: from rj.sgi.com ([204.94.215.100]:59780 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S271066AbRHOGlX>;
	Wed, 15 Aug 2001 02:41:23 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Brent Baccala <baccala@freesoft.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: enhanced spinlock debugging for intel - take 2 
In-Reply-To: Your message of "Tue, 14 Aug 2001 23:06:09 -0400."
             <3B79E721.A2E63A92@freesoft.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 15 Aug 2001 16:40:44 +1000
Message-ID: <2923.997857644@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2001 23:06:09 -0400, 
Brent Baccala <baccala@freesoft.org> wrote:
>I've revised and improved the intel spinlock debugging I posted two
>weeks ago.
>Make sure you do a "make dep" after applying the patch, since it exports
>symbols...

make mrproper; make dep is the only way to guarantee that module
symbol versions are correct after a patch.

