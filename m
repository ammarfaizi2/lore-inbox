Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbTKPUVP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 15:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbTKPUVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 15:21:15 -0500
Received: from mail.gmx.de ([213.165.64.20]:1704 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263137AbTKPUVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 15:21:12 -0500
X-Authenticated: #4512188
Message-ID: <3FB7DCF9.5090205@gmx.de>
Date: Sun, 16 Nov 2003 21:24:25 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031102
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Terrible interactivity with 2.6.0-t9-mm3
References: <20031116192643.GB15439@zip.com.au>
In-Reply-To: <20031116192643.GB15439@zip.com.au>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CaT wrote:

 > I just noticed major interactivity problems whilst ogging one of my

[...]

 > Doh. :/ This is the first time this has been so bad that I've felt
 > it was worth writing about. :/


Yup, I was using a patched mm3 so I wanted to try the plain one, but due 
to your post, I can conclude it really is mm3 which is really bad. I 
noticed this as well. Using Nick's CPU scheduler things are not thaaat 
bad, but still far from mm2. I think there is some major problem 
introduced to mm3. Without Nicks patch doing an emerge/compiling, even 
my mouse heavily stutters like hell, regradless of the used io 
scheduler. With Nick's patch the mouse is rather OK, but the rest if the 
system is still not really usable. It is not a HD problem...

Going back to mm2 (patched mm2) and everything it fine again.

Athlon XP 1900MHz
1GB DDR RAM
NFORCE2 Chipset

Prakash


