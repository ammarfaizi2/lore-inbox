Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbTKFXO1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 18:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263857AbTKFXO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 18:14:27 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:62681 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263850AbTKFXO0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 18:14:26 -0500
Date: Fri, 7 Nov 2003 07:21:20 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Andrey Borzenkov <arvidjaar@mail.ru>,
       Alistair J Strachan <alistair@devzero.co.uk>,
       Arjan van de Ven <arjanv@redhat.com>, <linux-kernel@vger.kernel.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [RFC] KBUILD 2.5 issues/regressions
In-Reply-To: <20031106172333.GA1097@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0311070719390.2959-100000@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Nov 2003, Sam Ravnborg wrote:

> 
> I am in the process of addressing this issue.
> What I plan to do is to provide a script solely for the purpose of building
> modules. This script will be simple but allow us to change the build process,
> without changing the way modules are build.
> In order to use module versioning the distributor needs to ship all
> modules. Otherwise the build process cannot look up a symbol exported
> in module A, used by module B.

Do you mean all modules that module A refers to.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/

