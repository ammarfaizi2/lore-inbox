Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132747AbRDXE2P>; Tue, 24 Apr 2001 00:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132752AbRDXE2F>; Tue, 24 Apr 2001 00:28:05 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:25105 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S132747AbRDXE15>; Tue, 24 Apr 2001 00:27:57 -0400
Message-Id: <200104240427.f3O4Ros93448@aslan.scsiguy.com>
To: David Santinoli <u235@libero.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx: first mount always fails 
In-Reply-To: Your message of "Fri, 13 Apr 2001 11:45:59 +0200."
             <20010413114559.A1133@aidi.santinoli.com> 
Date: Mon, 23 Apr 2001 22:27:50 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>The first attempt at mounting a disc in my Traxdata CDR drive after
>boot always fails. From the second on, everything works flawlessly.
>Current setup is 2.2.18 kernel + 6.1.11-2.2.18 patch, but I've been
>experiencing this behaviour since I bought the adapter (around 2.2.12 or so).
>aic7xxx gets loaded as a module.
>Here's some diagnostic info from the failed mount. If more is needed,
>please let me know.  (of course, a disc _is_ present in the drive).

My guess is that your CDROM drive takes longer than most to perform
the initial read capacity.  There is little to be done for this other
than uping the timeout value in the CD driver.

--
Justin
