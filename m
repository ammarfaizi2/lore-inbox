Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312414AbSEVXaf>; Wed, 22 May 2002 19:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312938AbSEVXae>; Wed, 22 May 2002 19:30:34 -0400
Received: from crack.them.org ([65.125.64.184]:57611 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S312414AbSEVXad>;
	Wed, 22 May 2002 19:30:33 -0400
Date: Wed, 22 May 2002 18:29:47 -0500
From: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: mgross@unix-os.sc.intel.com, Pavel Machek <pavel@suse.cz>,
        "Vamsi Krishna S." <vamsi_krishna@in.ibm.com>,
        Gross Mark <mark.gross@intel.com>, linux-kernel@vger.kernel.org,
        r1vamsi@in.ibm.com
Subject: Re: PATCH Multithreaded core dumps for the 2.5.17 kernel  was ....RE:    PATCH Multithreaded core dump support for the 2.5.14 (aO
Message-ID: <20020522182947.A16176@crack.them.org>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	mgross@unix-os.sc.intel.com, Pavel Machek <pavel@suse.cz>,
	"Vamsi Krishna S." <vamsi_krishna@in.ibm.com>,
	Gross Mark <mark.gross@intel.com>, linux-kernel@vger.kernel.org,
	r1vamsi@in.ibm.com
In-Reply-To: <200205222043.g4MKhsw06808@unix-os.sc.intel.com> <E17AeGS-0002wv-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 11:07:24PM +0100, Alan Cox wrote:
> > I think that although my tcore_suspend_threads and Pavel's freeze_processes 
> > have similar results, I don't think using Pavel's approach for the core dump 
> > is a good idea.
> 
> Migrating a task to a specific processor is also remarkably related. How does
> it wash out if the suspend thread/freeze process stuff works by migrating
> all the processes to a CPU that doesnt exist ?

I was under the impression that this is exactly how Mark was doing it,
actually.  Issues with semaphores aside...

-- 
Daniel Jacobowitz                           Debian GNU/Linux Developer
Monta Vista Software                              Debian Security Team
