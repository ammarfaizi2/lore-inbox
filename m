Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129543AbQLTKPH>; Wed, 20 Dec 2000 05:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129860AbQLTKO5>; Wed, 20 Dec 2000 05:14:57 -0500
Received: from slave1.aa.net ([204.157.220.252]:18180 "EHLO slave1.aa.net")
	by vger.kernel.org with ESMTP id <S129543AbQLTKOs>;
	Wed, 20 Dec 2000 05:14:48 -0500
X-Intended-For: linux-kernel@vger.kernel.org
Message-ID: <3A407F84.23E8733@scn.org>
Date: Wed, 20 Dec 2000 01:44:36 -0800
From: Nicholas Miell <bc543@scn.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Gennerat <christian.gennerat@vz.cit.alcatel.fr>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Announce: modutils 2.3.23 is available
In-Reply-To: <3249.977272993@kao2.melbourne.sgi.com> <3A407C5F.C8BC2802@vz.cit.alcatel.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Gennerat wrote:
> 
> About Standard aliases:
> > modprobe -c
> ...
> alias ppp-compress-21 bsd_comp
> ...
> 
> Why bsd_comp is the standard alias?
> /src/linux/Configure.help says that
> 
> The PPP Deflate compression method ("PPP Deflate compression",
>   above) is preferable to BSD-Compress, because it compresses better
>   and is patent-free.
> 

ppp-compress-21 refers to PPP compression method 21, which happens to
be BSD Compress. Deflate is 26 (and also 24, because it was assigned
that
value in the draft RFC).

Aliasing ppp-compress-21 to anything other than bsd_comp would break
PPP.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
