Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbTEFUi5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 16:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbTEFUi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 16:38:57 -0400
Received: from siaag1ab.compuserve.com ([149.174.40.4]:10158 "EHLO
	siaag1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S261844AbTEFUi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 16:38:56 -0400
Date: Tue, 6 May 2003 16:48:07 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: The disappearing sys_call_table export.
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, terje.eggestad@scali.com
Message-ID: <200305061650_MC3-1-379F-2FC9@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You might have a derivative work after obtaining access to a
> non-exported interface.  If this is correct, binary-only modules
> can't do this and therefore they must stick to exported interfaces.

  And what about modules that just hook syscall directly by hooking int
0x80 or messing with sysenter?
