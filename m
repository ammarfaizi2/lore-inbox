Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264054AbUFXJbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264054AbUFXJbs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 05:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbUFXJbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 05:31:48 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:36195 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264054AbUFXJbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 05:31:32 -0400
Date: Thu, 24 Jun 2004 02:31:09 -0700
From: Paul Jackson <pj@sgi.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: using gcc built-ins for bitops?
Message-Id: <20040624023109.6213c1ce.pj@sgi.com>
In-Reply-To: <20040624070936.GB30057@devserv.devel.redhat.com>
References: <20040624070936.GB30057@devserv.devel.redhat.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see a list of these gcc bitop builtins at the bottom of the page:

  http://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html

Looks like you can find the position of the first 1 bit, the length of
the leading or trailing seq of 0 bits, the hamming weight (popcount) and
the parity, each for int, long and long long.

I just add this for the benefit of others.

As to your primary question - is this worth doing - I don't have
an answer.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
