Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279839AbRKAWw4>; Thu, 1 Nov 2001 17:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279840AbRKAWwg>; Thu, 1 Nov 2001 17:52:36 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:30483 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S279839AbRKAWwc>;
	Thu, 1 Nov 2001 17:52:32 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: FORT David <popo.enlighted@free.fr>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Oops on 2.4.13 
In-Reply-To: Your message of "Thu, 01 Nov 2001 16:45:04 CDT."
             <3BE1C260.2010507@free.fr> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 02 Nov 2001 09:52:19 +1100
Message-ID: <1235.1004655139@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Nov 2001 16:45:04 -0500, 
FORT David <popo.enlighted@free.fr> wrote:
>the kernel is tainted but by a kernel driver which hasn't set
>any licence(can't remember which one)

modinfo `modprobe -l` | sed -ne '/^filename/h; /^license.*none/{g;p;}'

lists all modules without a license, please report so it can be fixed.

