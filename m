Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314145AbSDLV1i>; Fri, 12 Apr 2002 17:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314146AbSDLV1h>; Fri, 12 Apr 2002 17:27:37 -0400
Received: from air-2.osdl.org ([65.201.151.6]:47110 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S314145AbSDLV1g>;
	Fri, 12 Apr 2002 17:27:36 -0400
Date: Fri, 12 Apr 2002 14:22:48 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Ravi Wijayaratne <ravi_wija@yahoo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: /proc/stat page in and out values
In-Reply-To: <20020412211037.55635.qmail@web13409.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33L2.0204121422160.31668-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Apr 2002, Ravi Wijayaratne wrote:

| In /proc/stat the record as
|
| page x y
|
| which indicates cumulative page in and out values.
| To my best undertstanding this info is stored in
| kstat.pgpgin and kstat.pgpgout.
|
| However the values are incremented in submit_bh in
| ll_rw_blk.c. So are we actually counting the buffers
| we write in and out or the pages; or is it the same ?

Please see if
  http://marc.theaimsgroup.com/?l=linux-kernel&m=101770318012189&w=2
answers your questions.

-- 
~Randy

