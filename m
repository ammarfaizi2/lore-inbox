Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751484AbWEDLFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbWEDLFx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 07:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWEDLFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 07:05:53 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:62885 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751484AbWEDLFx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 07:05:53 -0400
Subject: Re: [RFC][PATCH -rt] Make futex_wait() use an hrtimer for timeout
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, dvhltc@us.ibm.com,
       Darren Hart <dvhltc@us.ibm.com>
In-Reply-To: <20060503203803.GA15414@elte.hu>
References: <20060412114243.42351c35@frecb000686>
	 <20060503203803.GA15414@elte.hu>
Date: Thu, 04 May 2006 13:10:04 +0200
Message-Id: <1146741005.18387.37.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 04/05/2006 13:08:41,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 04/05/2006 13:08:44,
	Serialize complete at 04/05/2006 13:08:44
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-03 at 22:38 +0200, Ingo Molnar wrote:
> * Sébastien Dugué <sebastien.dugue@bull.net> wrote:
> 
> >   This patch modifies futex_wait() to use an hrtimer + schedule() in 
> > place of schedule_timeout() in an RT kernel.
> 
> nice patch! Applied.
> 
> 	Ingo

  Thanks.

  Sébastien.


