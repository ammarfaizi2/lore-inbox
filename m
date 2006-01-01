Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWAAStT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWAAStT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 13:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWAAStT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 13:49:19 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:21904 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S932192AbWAAStS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 13:49:18 -0500
Date: Sun, 1 Jan 2006 19:49:16 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Jiri Slaby <xslaby@fi.muni.cz>
Cc: Mark v Wolher <trilight@ns666.com>, Sami Farin <7atbggg02@sneakemail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, arjan@infradead.org,
       jesper.juhl@gmail.com, s0348365@sms.ed.ac.uk, rlrevell@joe-job.com,
       mchehab@brturbo.com.br, video4linux-list@redhat.com
Subject: Re: system keeps freezing once every 24 hours / random apps crashing
Message-ID: <20060101184916.GE27444@vanheusden.com>
References: <43B67DB6.2070201@ns666.com> <43B6A14E.1020703@ns666.com>
	<20051231163414.GE3214@m.safari.iki.fi>
	<20051231163414.GE3214@m.safari.iki.fi>
	<43B6B669.6020500@ns666.com> <43B73DEB.4070604@ns666.com>
	<43B7D3BE.60003@ns666.com> <43B7EB99.8010604@ns666.com>
	<43B7EB99.8010604@ns666.com>
	<20060101183832.2BE0222AEE7@anxur.fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060101183832.2BE0222AEE7@anxur.fi.muni.cz>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Mon Jan  2 17:36:49 CET 2006
X-Message-Flag: PGP key-id: 0x1f28d8ae - consider encrypting your e-mail to me
	with PGP!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Okay, here are the test results:
> >- heavy load + nvidia (binary module) + bttv with grabdisplay = crash
> >- heavy load + nv (not tainted kernel) + bttv with grabdisplay = crash
> >- heavy load + nvidia (binary module) + bttv with overlay = OK
> >- heavy load + nv (not tainted kernel) + bttv with overlay = OK
> >Adding vmware on top of it will cause the system sooner to freeze/crash
> >(using grabdisplay)
> >So what you think guys?

Just to add:
something else is fishy: when I start iptraf (or some other traffic
dumper) my system hangs up. repeatable. also with a bttv card which is
occasionally used for grabbing videotext pages


Folkert van Heusden

-- 
Try MultiTail! Multiple windows with logfiles, filtered with regular
expressions, colored output, etc. etc. www.vanheusden.com/multitail/
----------------------------------------------------------------------
Get your PGP/GPG key signed at www.biglumber.com!
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
