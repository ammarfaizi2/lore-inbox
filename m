Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264531AbUDUKnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbUDUKnf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 06:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264532AbUDUKnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 06:43:35 -0400
Received: from post1.dk ([62.242.36.44]:50443 "EHLO post1.dk")
	by vger.kernel.org with ESMTP id S264531AbUDUKne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 06:43:34 -0400
Content-Disposition: inline
Content-Transfer-Encoding: binary
MIME-Version: 1.0
To: Axel =?iso-8859-2?q?Wei=DF?= <aweiss@informatik.hu-berlin.de>
Subject: Re: build system broken in 2.6.6rc1 for external modules?
From: sam@ravnborg.org
Reply-To: sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org, Arkadiusz Miskiewicz <arekm@pld-linux.org>
Content-Type: text/plain; charset=iso-8859-1
X-Mailer: acmemail <URL:http://www.astray.com/acmemail/>
Message-Id: <20040421104333.B646015C30@post1.dk>
Date: Wed, 21 Apr 2004 12:43:33 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> This will start building kernel for me! I don't want that. I want
>only few
>> external modules to be built.
>
>If you are interested, I will send you a brief Makefile for
>compiling external 
>modules. It works on a clean kernel source tree without compiling
>the whole 
>kernel.

With the patch that went into -rc2-mm1 there is no longer a need
to build the full kernel.
Previously kbuild required the Module.symvers file to be present,
but with the latest patch this requirement is relaxed.

   Sam
