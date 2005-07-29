Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbVG2Gzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbVG2Gzl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 02:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVG2Gzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 02:55:40 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:63643 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261642AbVG2Gzh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 02:55:37 -0400
Subject: Re: [PATCH 0/5] Add kernel AIO support for POSIX AIO
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: "linux-aio kvack.org" <linux-aio@kvack.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1122565588.2019.79.camel@frecb000686>
References: <1122565588.2019.79.camel@frecb000686>
Date: Fri, 29 Jul 2005 08:54:25 +0200
Message-Id: <1122620065.2019.90.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/07/2005 09:07:41,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/07/2005 09:07:43,
	Serialize complete at 29/07/2005 09:07:43
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-28 at 17:46 +0200, Sébastien Dugué wrote:
> infrastructure to be used by user level libraries aiming at implementing
> a POSIX compliant API on top of this kernel support.
> 
>   This patchset is comprised of 5 patches, each implementing a specific
> functionality:
> 
> 	- aiomaxevents: adds a sysctl variable for setting the default 
> 	  AIO context event ring size at runtime. This tunable is 
> 	  accessible via /proc/sys/fs/posix-aio-default-max-nr.
> 
> 	- aioevent: adds support for request completion notification.
> 
> 	- lioevent: adds support for list of requests completion 
> 	  notification.
> 
> 	- liowait: adds support for the POSIX listio LIO_WAIT mechanism.
> 
> 	- cancelfd: adds support for cancellation against a file 
> 	  descriptor.
> 
>  These patches apply cleanly on a vanilla 2.6.12 kernel tree and should 
> be applied in the order shown before.
> 


  Sorry forgot to credit Laurent Vivier as the main author of these
patches.

  Sébastien.

-- 
------------------------------------------------------

  Sébastien Dugué                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
  
------------------------------------------------------

