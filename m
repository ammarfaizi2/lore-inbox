Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUAEX63 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 18:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265996AbUAEXyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 18:54:43 -0500
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:43740 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S266013AbUAEXve convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 18:51:34 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: mru@kth.se (=?iso-8859-1?q?M=E5ns?= =?iso-8859-1?q?=20Rullg=E5rd?=),
       linux-kernel@vger.kernel.org
Subject: Re: GCC 3.4 Heads-up
Date: Tue, 6 Jan 2004 00:49:31 +0100
User-Agent: KMail/1.5.4
References: <bsgav5$4qh$1@cesium.transmeta.com> <3FF8BDBB.4060708@tmr.com> <yw1xu13b2mz5.fsf@ford.guide>
In-Reply-To: <yw1xu13b2mz5.fsf@ford.guide>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200401060049.35935.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 05 January 2004 02:38, Måns Rullgård wrote:
> What's wrong with
>
> 	d = long_expression;
>  	if (a)
>  		b = d;
>  	else
>  		c = d;
>
> Your long expression is still only in one place.

This seperates control and data flow quite nicely, which is good
programming practise anyway and helps the compiler optimizing, AFAIK.

Regards

Ingo Oeser

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/+fgMU56oYWuOrkARAlOIAJ0c9QMsQRrXYv3RIV3r+8uAnJgETQCfQ7PJ
Zscp0VfGY2jS1RvWnuCAqoc=
=kY28
-----END PGP SIGNATURE-----

