Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315483AbSFEXln>; Wed, 5 Jun 2002 19:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316322AbSFEXlm>; Wed, 5 Jun 2002 19:41:42 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:60170 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S315483AbSFEXlm>;
	Wed, 5 Jun 2002 19:41:42 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Dave Jones <davej@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.20 i2c uses nonexistent linux/i2c-old.h 
In-Reply-To: Your message of "Wed, 05 Jun 2002 19:17:19 +0200."
             <20020605191719.H11945@suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Jun 2002 09:41:32 +1000
Message-ID: <30528.1023320492@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2002 19:17:19 +0200, 
Dave Jones <davej@suse.de> wrote:
>Why is kbuild2.5 expanding <linux/foo.h> to /usr/include/linux/foo.h ?
>If $sourcetree/include/linux/foo.h doesn't exist, it should stop
>compiling, not look in /usr/include/ for a (obsolete/wrong) alternative.

The nostdinc code in core-15 was incomplete, it was corrected in
core-16 which then highlighted the missing includes.  Just a bug.

