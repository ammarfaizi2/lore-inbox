Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270964AbRHTAuZ>; Sun, 19 Aug 2001 20:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270969AbRHTAuF>; Sun, 19 Aug 2001 20:50:05 -0400
Received: from relais.videotron.ca ([24.201.245.36]:31644 "EHLO
	VL-MS-MR004.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S270964AbRHTAtx>; Sun, 19 Aug 2001 20:49:53 -0400
Message-ID: <3B8060DE.1BF115EF@mcgill.ca>
Date: Sun, 19 Aug 2001 20:59:10 -0400
From: Pierre Cyr <pierre.cyr@mcgill.ca>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.9 Compile problem fix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I had to add a:

#include <linux/kernel.h>

to the file:

fs/ntfs/unistr.c

in order to get it to compile in the 2.4.9 kernel...  The macro:

min(x,y) (((x)<(y))?(x):(y))

does not get included otherwise.

Cheers,

Pierre

