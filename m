Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261947AbREYVqF>; Fri, 25 May 2001 17:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261950AbREYVpz>; Fri, 25 May 2001 17:45:55 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:30729 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S261947AbREYVpl>; Fri, 25 May 2001 17:45:41 -0400
Message-Id: <200105252145.f4PLjJaC004054@pincoya.inf.utfsm.cl>
To: Mark Frazer <mark@somanetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [timer] max timeout 
In-Reply-To: Your message of "Fri, 25 May 2001 17:26:28 -0400."
             <20010525172628.P32217@somanetworks.com> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Fri, 25 May 2001 17:45:19 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Frazer <mark@somanetworks.com> said:

[...]

> The output of `find . -type f | xargs grep 'jiffies +'` would suggest
> that there are a few latent bugs as jiffies grows to values near the
> top of its range.  I guess this hasn't turned up as 0x7fffffff / (100 *
> 3600 * 24) = 248.55.

There were patches floating around a _long_ time ago (2.1-ish AFAIR) that
allowed you to start your system at any jiffy. Many people checked out what
happens on jiffie rollover then. Might be a good idea to do that again...
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
