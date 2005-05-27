Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262631AbVE0Wdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262631AbVE0Wdu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 18:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbVE0Wdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 18:33:49 -0400
Received: from [62.81.186.15] ([62.81.186.15]:17329 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S262631AbVE0Wcl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 18:32:41 -0400
Date: Fri, 27 May 2005 22:32:13 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.12-rc5-mm1
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Rafael J. Wysocki'" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       tomlins@cam.org, linux-kernel@vger.kernel.org,
       alsa-devel@lists.sourceforge.net
References: <200505271738.j4RHcqg04138@unix-os.sc.intel.com>
In-Reply-To: <200505271738.j4RHcqg04138@unix-os.sc.intel.com> (from
	kenneth.w.chen@intel.com on Fri May 27 19:38:52 2005)
X-Mailer: Balsa 2.3.2
Message-Id: <1117233133l.7104l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.219.120] Login:jamagallon@able.es Fecha:Sat, 28 May 2005 00:32:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.27, Chen, Kenneth W wrote:
> Rafael J. Wysocki wrote on Friday, May 27, 2005 3:29 AM
> > > I assume the problem is due to one of the ASLA patches in rc5-mm1, but it's
> > > possible that it lies elsewhere.
> > 
> > Well, yes.  Apparently, it goes away if you revert the following patch:
> > 
> > avoiding-mmap-fragmentation-fix-2.patch
> 
> 
> avoiding-mmap-fragmentation-fix-2.patch has a major clash using
> vm_private_data where alsa is also using.  I just posted a patch,
> please try that out.  Thanks.
> 
> http://marc.theaimsgroup.com/?l=linux-mm&m=111721191501940&w=2
> 

This makes my oopses go away in beep-media-player.
Thanks!

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.11-jam20 (gcc 4.0.0 (4.0.0-3mdk for Mandriva Linux release 2006.0))


