Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270165AbUJTJIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270165AbUJTJIf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 05:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270305AbUJTJIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 05:08:19 -0400
Received: from almesberger.net ([63.105.73.238]:8464 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S270165AbUJTJE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 05:04:58 -0400
Date: Wed, 20 Oct 2004 06:04:51 -0300
From: Werner Almesberger <werner@almesberger.net>
To: Len Brown <len.brown@intel.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] boot parameters: quoting of environment variablesrevisited
Message-ID: <20041020060451.R18873@almesberger.net>
References: <1098253261.10571.129.camel@localhost.localdomain> <1098256561.26603.4289.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098256561.26603.4289.camel@d845pe>; from len.brown@intel.com on Wed, Oct 20, 2004 at 03:16:01AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:
> I'm not sure what quoted parameters for init's environment are used for,
> but it looks like FOO="FOO BAR" now results in
> FOO=FOO BAR
> in the environment.

E.g. when passing data into a UML kernel, it's handy if you can
use parts of the host environment, such as PATH or cwd, even if
the user has a somewhat strange setup, with spaces in them.

That would be for things like "run this test script from my
PATH, using files in the current directory, as 'init' under that
kernel".

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
