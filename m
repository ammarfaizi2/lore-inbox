Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267005AbSKPADJ>; Fri, 15 Nov 2002 19:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267033AbSKPADI>; Fri, 15 Nov 2002 19:03:08 -0500
Received: from AGrenoble-101-1-5-56.abo.wanadoo.fr ([80.11.136.56]:47879 "EHLO
	microsoft.com") by vger.kernel.org with ESMTP id <S267005AbSKPADI>;
	Fri, 15 Nov 2002 19:03:08 -0500
Subject: Re: Reserving "special" port numbers in the kernel ?
From: Xavier Bestel <xavier.bestel@free.fr>
To: Arun Sharma <arun.sharma@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <uel9mbcyi.fsf@unix-os.sc.intel.com>
References: <uel9mbcyi.fsf@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1037405489.8019.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1 (Preview Release)
Date: 16 Nov 2002 01:11:30 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le sam 16/11/2002 Ã  01:00, Arun Sharma a Ã©critÂ :
> One of the Intel server platforms has a magic port number (623) that
> it uses for remote server management. However, neither the kernel nor
> glibc are aware of this special port.
> 
> As a result, when someone requests a privileged port using
> bindresvport(3), they may get this port back and bad things happen.
> 
> Has anyone run into this or similar problems before ? Thoughts on
> what's the right place to handle this issue ?

run a dummy app at startup which reserves that port ?

