Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264963AbRGEWT0>; Thu, 5 Jul 2001 18:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264917AbRGEWTR>; Thu, 5 Jul 2001 18:19:17 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:52241 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264837AbRGEWTL>;
	Thu, 5 Jul 2001 18:19:11 -0400
Date: Thu, 5 Jul 2001 15:17:25 -0700
From: Greg KH <greg@kroah.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: about include/linux/macros.h ...
Message-ID: <20010705151725.A6021@kroah.com>
In-Reply-To: <XFMail.20010704163351.davidel@xmailserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <XFMail.20010704163351.davidel@xmailserver.org>; from davidel@xmailserver.org on Wed, Jul 04, 2001 at 04:33:51PM -0700
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2001 at 04:33:51PM -0700, Davide Libenzi wrote:
> 
> What about the creation of such file containing useful macros like min(),
> max(), abs(), etc.. that otherwise everyone is forced to define like :

See include/linux/netfilter.h, around line 164 for the reason why there
isn't a kernel wide min() or max() macro.

greg k-h
