Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284820AbRLKCKz>; Mon, 10 Dec 2001 21:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284812AbRLKCKp>; Mon, 10 Dec 2001 21:10:45 -0500
Received: from sj1-3-1-20.securesites.net ([192.220.127.117]:49924 "EHLO
	sj1-3-1-20.securesites.net") by vger.kernel.org with ESMTP
	id <S284808AbRLKCKg>; Mon, 10 Dec 2001 21:10:36 -0500
Date: Tue, 11 Dec 2001 02:10:32 +0000
From: Nathan Myers <ncm-nospam@cantrip.org>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br, torvalds@transmeta.com, alan@redhat.com,
        VDA@port.imtp.ilyichevsk.odessa.ua
Subject: [PATCH] memory corruption in i2o
Message-ID: <20011211021032.A65086@cantrip.org>
Mail-Followup-To: Nathan Myers <ncm-nospam@cantrip.org>,
	linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
	torvalds@transmeta.com, alan@redhat.com,
	VDA@port.imtp.ilyichevsk.odessa.ua
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some weeks back "VDA@port.imtp.ilyichevsk.odessa.ua" reported in

  http://marc.theaimsgroup.com/?l=linux-kernel&m=100633930427682&w=2

a bug in an i2o header file that causes kernel memory corruption.  
The obvious fix was posted several times; this one from Andreas Dilger

  http://marc.theaimsgroup.com/?l=linux-kernel&m=100688659819007&w=2

is typical.  The fix appears not to have been picked up in 2.4.17-pre8.
There is no i2o maintainer listed in MAINTAINERS.

With a 2.4.17 release candidate coming up, it's probably time to 
apply it.

The original posting noted several other similar bugs, for which it
and subsequent postings suggested fixes, e.g.

  http://marc.theaimsgroup.com/?l=linux-kernel&m=100634117104111&w=2

Is anybody going to pick up _any_ of these fixes, or do they just rot
until enough kernel crashes get reported with enough detail to implicate
the identified bugs?  

Nathan Myers
ncm at cantrip dot org
