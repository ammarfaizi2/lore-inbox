Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277064AbRJKXef>; Thu, 11 Oct 2001 19:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277065AbRJKXeO>; Thu, 11 Oct 2001 19:34:14 -0400
Received: from ns.ithnet.com ([217.64.64.10]:34830 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S277064AbRJKXeJ>;
	Thu, 11 Oct 2001 19:34:09 -0400
Date: Fri, 12 Oct 2001 01:34:21 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Partitioning problems in 2.4.11
Message-Id: <20011012013421.5ede2ab1.skraw@ithnet.com>
In-Reply-To: <Pine.GSO.4.21.0110111854080.24742-100000@weyl.math.psu.edu>
In-Reply-To: <20011012003148.B435@christian.chrullrich.de>
	<Pine.GSO.4.21.0110111854080.24742-100000@weyl.math.psu.edu>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2001 18:59:03 -0400 (EDT) Alexander Viro <viro@math.psu.edu>
wrote:

> 
> 
> On Fri, 12 Oct 2001, Christian Ullrich wrote:
> 
> > a) -10-ac11, -10-ac12 and -12 with your patch all behave like -11.
> 
> _Ouch_.  So even bread()-based variant fails to read extended partition
> table in some cases.
> 
> Hmm... Just in case - what processor are you using?

Hi Alexander,

just a short comment: I got a host with PIII-500 and the same problem. A
partition on primary IDE (single partition for whole drive) vanished during use
of 2.4.10(SuSE 7.3)/11. System works flawlessly otherwise. It is booting from
SCSI, ide was only data :-). It has 384 MB RAM.

Regards,
Stephan

