Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266987AbSLWWKQ>; Mon, 23 Dec 2002 17:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266989AbSLWWKQ>; Mon, 23 Dec 2002 17:10:16 -0500
Received: from smtp.actcom.co.il ([192.114.47.13]:2471 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S266987AbSLWWKP>; Mon, 23 Dec 2002 17:10:15 -0500
Subject: RE: PAGE = 1k
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: User & <breno_silva@beta.bandnet.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <1040681542.5839.8.camel@gby.benyossef.com>
References: <20021223165245.M26209@beta.bandnet.com.br> 
	<1040681542.5839.8.camel@gby.benyossef.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 24 Dec 2002 00:18:28 +0200
Message-Id: <1040681908.5944.2.camel@gby.benyossef.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-24 at 00:12, Gilad Ben-Yossef wrote:
> If so, you might want to check out how the Millipede system from the
> Technion works - it basically creates several "views" of a page using
> segmentation and other MMU features which creates artifical locality of
> memory structures on the same page in units smaller then a hardware
> page. 

Bah... forgot the link:
http://www.cs.technion.ac.il/Labs/dsl/projects/millipede/default.htm

and you might have to dig through to find the actual place where they
discuss this particular technique. AFAIK they've tried many different
one and this ISN'T the one they're currently implementing...

-- 
Gilad Ben-Yossef <gilad@benyossef.com>
http://benyossef.com

 "Geeks rock bands cool name #8192: RAID against the machine"

