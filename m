Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbTDFV6E (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 17:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263129AbTDFV6D (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 17:58:03 -0400
Received: from mario.gams.at ([194.42.96.10]:9307 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id S263128AbTDFV54 convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 17:57:56 -0400
X-Mailer: exmh version 2.6.1 18/02/2003 with nmh-1.0.4
From: Bernd Petrovitsch <bernd@gams.at>
To: steve.cameron@hp.com
cc: linux-kernel@vger.kernel.org
Subject: Re: How to speed up building of modules? 
References: <20030404085740.GA10052@zuul.cca.cpqcorp.net> 
In-reply-to: Your message of "Fri, 04 Apr 2003 14:57:40 +0600."
             <20030404085740.GA10052@zuul.cca.cpqcorp.net> 
X-url: http://www.luga.at/~bernd/
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Mon, 07 Apr 2003 00:09:03 +0200
Message-ID: <7449.1049666943@frodo.gams.co.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Cameron <steve.cameron@hp.com> wrote:
>With all the distributions, and differnent
>offerings of distributions, and errata kernels... today, I count
>almost 40 distinct kernels we're trying to support, not counting the
>mainline development on kernel.org, and not counting multiple
>config file variations for each of those 40 or so kernels.
>
>The main catch seems to be the symbol checksums.  In order for those
>to match (and I'm not too interested in subverting those), the 
>config files used during the compile need to be very similar.  That 
>means building lots and lots of modules.  (Think about all the 
>modules which are enabled in redhat's typical default config files.)
>This takes time.  Mulitply 3 drivers * ~40 kernels * several config
>files, and pretty soon... well, pretty soon you don't remember
>what "preety soon" means.
[...]
>Any ideas?

http://ccache.samba.org/

	Bernd
-- 
Bernd Petrovitsch                              Email : bernd@gams.at
g.a.m.s gmbh                                  Fax : +43 1 205255-900
Prinz-Eugen-Straﬂe 8                    A-1040 Vienna/Austria/Europe
                     LUGA : http://www.luga.at


