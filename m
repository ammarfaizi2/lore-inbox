Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135630AbRDSLkW>; Thu, 19 Apr 2001 07:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135629AbRDSLkM>; Thu, 19 Apr 2001 07:40:12 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:60687 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S135628AbRDSLjz> convert rfc822-to-8bit; Thu, 19 Apr 2001 07:39:55 -0400
From: s-jaschke@t-online.de (Stefan Jaschke)
Reply-To: stefan@jaschke-net.de
Organization: jaschke-net.de
To: Jens Axboe <axboe@suse.de>
Subject: Re: Problems with Toshiba SD-W2002 DVD-RAM drive (IDE)
Date: Thu, 19 Apr 2001 13:39:38 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01041714250400.01376@antares> <20010418123941.H492@suse.de> <20010418143953.D490@suse.de>
In-Reply-To: <20010418143953.D490@suse.de>
MIME-Version: 1.0
Message-Id: <01041913393800.01240@antares>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

I applied your patch to 2.4.4-pre4. It compiled fine, but crashed during
boot (just right after the IDE init) with
-------------------
Uniform CD-ROM driver Revision: 3.12
Unable to handle kernel NULL pointer dereference at virtual address 00000000
printing eip: ...
Oops: 0000
...
-------------------

I looked up the eip. It's in 
c01a5490 t cdrom_get_entry
c01a5490 t gcc2_compiled.
(Although I don't know what the second line on the same address means.) 

Please let me know, if you need more info or I can help in any other way.

Thanks,
Stefan
