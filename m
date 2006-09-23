Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbWIWNNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWIWNNF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 09:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbWIWNNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 09:13:05 -0400
Received: (root@vger.kernel.org) by vger.kernel.org id S1751053AbWIWNNF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 09:13:05 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:23377 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750699AbWIWB62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 21:58:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VQvACBCzw1MYu9efdlCAJuHaBeovAwA6GJlWY3ijBjS3UNH74xHuYrGHATFKjEDup7njbZx/yU0cEaiNa9cWYKNf3k54UPTJK6D642A1w7CxOLMEcESEBMXvgPNAXei9LtQLBBujqjvps+rTzbVGD13piOPQEIxEYePXrj7jUIA=
Message-ID: <8bd0f97a0609221858w442b9aeagcff312d2220f70c6@mail.gmail.com>
Date: Fri, 22 Sep 2006 21:58:27 -0400
From: "Mike Frysinger" <vapier.adi@gmail.com>
To: "Roland Dreier" <rdreier@cisco.com>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, "Arnd Bergmann" <arnd@arndb.de>,
       "Luke Yang" <luke.adi@gmail.com>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	Randy.Dunlap<rdunlap@xenotime.net>
				    ^-missing end of address
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	Randy.Dunlap<rdunlap@xenotime.net>
				    ^-missing end of address
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	Randy.Dunlap<rdunlap@xenotime.net>
				    ^-missing end of address
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	Randy.Dunlap<rdunlap@xenotime.net>
				    ^-missing end of address
In-Reply-To: <adad59nfk97.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com>
	 <200609230218.36894.arnd@arndb.de>
	 <20060922181826.3b209d1d.rdunlap@xenotime.net>
	 <adad59nfk97.fsf@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/06, Roland Dreier <rdreier@cisco.com> wrote:
>  > > > +static char *cplb_print_entry(char *buf, int type)
>
>  > examples of acceptable interfaces?
>
> I don't know exactly what a CPLB is, but it looks like this file is
> something debugging-related.  So stick it in debugfs?

a CPLB is a blackfinisim for handling cache ... it stands for Cache
Protection Lookaside Buffer

and yes, our proc file for displaying the current software copies of
the data cplb and instruction cplb tables would probably be better
implemented via debugfs as there is no real upper limit on how big the
table can grow ...
-mike
