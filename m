Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265542AbUGZTsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265542AbUGZTsh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 15:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265996AbUGZTsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 15:48:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28392 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265542AbUGZSvc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 14:51:32 -0400
To: root@chaos.analogic.com
Cc: Keith Owens <kaos@ocs.com.au>, Mikael Pettersson <mikpe@csd.uu.se>,
       jamagallon@able.es, linux-kernel@vger.kernel.org
Subject: Re: 2.4.27+stdarg+gcc-3.4.1
References: <18199.1090681162@ocs3.ocs.com.au>
	<Pine.LNX.4.53.0407241958490.3373@chaos>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 26 Jul 2004 15:49:16 -0300
In-Reply-To: <Pine.LNX.4.53.0407241958490.3373@chaos>
Message-ID: <orhdruzjrn.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 24, 2004, "Richard B. Johnson" <root@chaos.analogic.com> wrote:

> I have found it necessary to use -I`gcc --print-file-name=include`

Never ever do that.  Use -isystem instead of -I, if you have to, but
having system headers handled as non-system headers may get you in
trouble.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
