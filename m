Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264865AbTF0W37 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 18:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbTF0W36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 18:29:58 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:24328 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S264865AbTF0W3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 18:29:53 -0400
To: Willy Tarreau <willy@w.ods.org>
Cc: rth@twiddle.net, linux-kernel@vger.kernel.org
Subject: Re: [ALPHA][2.5.7x] Problems with execve assembly rewriting
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
References: <wrp4r2cpqye.fsf@hina.wild-wind.fr.eu.org>
	<20030627202210.GA29680@alpha.home.local>
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Sat, 28 Jun 2003 00:42:37 +0200
Message-ID: <wrpbrwjnnvm.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <20030627202210.GA29680@alpha.home.local> (Willy Tarreau's
 message of "Fri, 27 Jun 2003 22:22:10 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Willy" == Willy Tarreau <willy@w.ods.org> writes:

Willy> So it may result from some garbage being used as a pointer, or
Willy> a char * being jumped to.

Well, problem was in fact a broken binutils package. Upgrading to
2.13.90.0.18 let the system boot fine, while 2.13.90.0.10 leads to
this strange crash...

     M.
-- 
Places change, faces change. Life is so very strange.
