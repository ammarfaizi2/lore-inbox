Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268113AbUIAW4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268113AbUIAW4O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 18:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267681AbUIAWxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 18:53:08 -0400
Received: from users.linvision.com ([62.58.92.114]:47580 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S267421AbUIAWvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 18:51:01 -0400
Date: Thu, 2 Sep 2004 00:51:00 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pwc+pwcx is not illegal
Message-ID: <20040901225100.GA28809@bitwizard.nl>
References: <6.1.2.0.2.20040828141825.01e5e7d8@inet.uni2.dk> <20040828131138.GZ12772@fs.tum.de> <1093788177.27901.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093788177.27901.37.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I don't want to get into the whole discussion. However, 

--------------------

int pwcx_init_decompress_Timon (int a,int b,int c, int d)

{
  return pwc_init_decompress_common (a, c, d); 
}

void pwcx_exit_decompress_Timon (void)
{
}

int pwcx_init_decompress_Kiara (int a,int b,int c, int d)

{
  return pwc_init_decompress_common (a, c, d); 
}

void pwcx_exit_decompress_Kiara (void)
{
}

--------------------

compiles with 

	gcc -m486 -Wall -O2 pwcx_test.c -S

into the same assembly as found in libpwcx.a ...

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
