Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267159AbSKPAqZ>; Fri, 15 Nov 2002 19:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267168AbSKPAqZ>; Fri, 15 Nov 2002 19:46:25 -0500
Received: from fmr03.intel.com ([143.183.121.5]:39140 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP
	id <S267159AbSKPAqY> convert rfc822-to-8bit; Fri, 15 Nov 2002 19:46:24 -0500
To: xavier.bestel@free.fr (Xavier Bestel)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reserving "special" port numbers in the kernel ?
References: <1037405489.8019.10.camel@localhost>
From: Arun Sharma <arun.sharma@intel.com>
Date: 15 Nov 2002 16:53:15 -0800
In-Reply-To: <1037405489.8019.10.camel@localhost>
Message-ID: <uadkabais.fsf@unix-os.sc.intel.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

xavier.bestel@free.fr (Xavier Bestel) writes:

> Le sam 16/11/2002 Ã  01:00, Arun Sharma a Ã©critÂ :
> > One of the Intel server platforms has a magic port number (623) that
> > it uses for remote server management. However, neither the kernel nor
> > glibc are aware of this special port.
> > 
> > As a result, when someone requests a privileged port using
> > bindresvport(3), they may get this port back and bad things happen.
> > 
> > Has anyone run into this or similar problems before ? Thoughts on
> > what's the right place to handle this issue ?
> 
> run a dummy app at startup which reserves that port ?

Yes, I'm already aware of this one, but was looking for a lighter weight
solution (ideally a config file change) that doesn't involve running an
extra process (think of doing this on a large number of machines).

        -Arun

