Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265766AbUFIMy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265766AbUFIMy0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 08:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265782AbUFIMy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 08:54:26 -0400
Received: from moutng.kundenserver.de ([212.227.126.184]:64511 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265766AbUFIMyY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 08:54:24 -0400
From: Christian Borntraeger <linux-kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [STACK] >3k call path in xfs
Date: Wed, 9 Jun 2004 14:54:17 +0200
User-Agent: KMail/1.6.2
References: <20040609122647.GF21168@wohnheim.fh-wedel.de>
In-Reply-To: <20040609122647.GF21168@wohnheim.fh-wedel.de>
Cc: nathans@sgi.com, owner-xfs@oss.sgi.com,
       =?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200406091454.21182.linux-kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> 3k is not really bad yet, I just like to keep 1k of headroom for
> surprises like an extra int foo[256] in a structure.
> stackframes for call path too long (3064):
[...]
>       12  panic
[...]

I agree thats good to reduce stack size. 

On the other hand I think call traces containing panic are not a call trace 
I want to see at all.

cheers

Christian
