Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbTEVLwE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 07:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTEVLwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 07:52:04 -0400
Received: from pgramoul.net2.nerim.net ([80.65.227.234]:24721 "EHLO
	philou.aspic.com") by vger.kernel.org with ESMTP id S261790AbTEVLwC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 07:52:02 -0400
Date: Thu, 22 May 2003 14:05:02 +0200
From: Philippe =?ISO-8859-15?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.69-mm8
Message-Id: <20030522140502.1ea09342.philippe.gramoulle@mmania.com>
In-Reply-To: <20030522021652.6601ed2b.akpm@digeo.com>
References: <20030522021652.6601ed2b.akpm@digeo.com>
Organization: Lycos Europe
X-Mailer: Sylpheed version 0.8.11claws141 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Andrew,

It works fine here on a Dell Inspiron 8000 using elevator=as

I have a minor warning for the i8k module though:

WARNING: /lib/modules/2.5.69-mm8/kernel/drivers/char/i8k.ko needs unknown symbol SET_MODULE_OWNER

Thanks,

Philippe

--

Philippe Gramoullé
philippe.gramoulle@mmania.com
Lycos Europe - NOC France



On Thu, 22 May 2003 02:16:52 -0700
Andrew Morton <akpm@digeo.com> wrote:

  | 
  | ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/2.5.69-mm8/
  | 
  | . One anticipatory scheduler patch, but it's a big one.  I have not stress
  |   tested it a lot.  If it explodes please report it and then boot with
  |   elevator=deadline.
  | 
  | . The slab magazine layer code is in its hopefully-final state.
  | 
  | . Some VFS locking scalability work - stress testing of this would be
  |   useful.
  | 
