Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264902AbTFCC5a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 22:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264904AbTFCC5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 22:57:30 -0400
Received: from mout0.freenet.de ([194.97.50.131]:34759 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S264902AbTFCC53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 22:57:29 -0400
From: Andreas Hartmann <andihartmann@freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: Re: [PATCH] rmap 15j for 2.4.21-rc6
Date: Tue, 03 Jun 2003 05:16:36 +0200
Organization: privat
Message-ID: <bbh3uk$1a7$1@ID-44327.news.dfncis.de>
References: <fa.hqlmaq3.1ck6lpl@ifi.uio.no> <fa.g746m1f.1u52e03@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: susi.maya.org 1054610196 1351 192.168.1.3 (3 Jun 2003 03:16:36 GMT)
X-Complaints-To: abuse@fu-berlin.de
User-Agent: KNode/0.7.2
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Willy Tarreau wrote:

> Hi !
> 
> On Mon, Jun 02, 2003 at 06:55:48PM +0200, Andreas Hartmann wrote:
>> Michael Frank wrote:
> <...>
>> > GNU bash, version 2.05b.0(1)-release (i386-redhat-linux-gnu)
>> 
>> 2.02.1(1)-release
> <...>
>> > -   while (( i-- )); do
>> > +   while (( i=`expr $i - 1` )); do
>> > 
>> > In your opinion are your changes more portable across a wide range of
>> > systems?
>> 
>> I didn't think at portability :-). I only made it working for me. Maybe
>> there are other persons out there who do have some old versions too - so
>> they can use this patch.
> 
> Well, I found that i--/i++ don't work with bash-2.03 (present about
> everywhere) but i=i-1 or i=i+1 work well. So at least, for portability,
> this could be rewritten as "while (( i=i-1 )); do".

Works fine with 2.02.1, too.


Regards,
Andreas Hartmann
