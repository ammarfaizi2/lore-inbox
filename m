Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318772AbSHTOF0>; Tue, 20 Aug 2002 10:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318842AbSHTOF0>; Tue, 20 Aug 2002 10:05:26 -0400
Received: from mail3.alphalink.com.au ([202.161.124.59]:19233 "EHLO
	mail3.alphalink.com.au") by vger.kernel.org with ESMTP
	id <S318772AbSHTOF0>; Tue, 20 Aug 2002 10:05:26 -0400
Message-ID: <3D624DB8.1EA1840E@alphalink.com.au>
Date: Wed, 21 Aug 2002 00:10:00 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Peter Samuelson <peter@cadcamlab.org>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
References: <Pine.LNX.4.44.0208191157000.8911-100000@serv>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> 
> I looked through the list and except from real syntax errors nothing
> prevents an automatic conversion.
> I have to manually fix things like CONFIG_ALPHA_NONAME, which is first set
> by a choice statement and later redefined. My new parser can't deal with
> this, because user input is given the highest priority.

Well then, there's something we need to look at fixing in the CML1
corpus.

Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.
