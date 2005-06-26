Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbVFZWzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbVFZWzt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 18:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbVFZWzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 18:55:48 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:4537 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261635AbVFZWy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 18:54:26 -0400
Message-ID: <42BF3221.3000909@namesys.com>
Date: Sun, 26 Jun 2005 15:54:25 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: David Masover <ninja@slaphack.com>, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu>            <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu>
In-Reply-To: <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

> (Hint - work out how long a kernel 'make' would take
>if you were doing it inside a .tar.bz2).
>  
>
After the first time, not very long, if you had enough ram....  the
plugin would keep the data uncompressed until it flushed it to disk.

Performance might even improve since less would be written to disk.
