Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319021AbSH1WGM>; Wed, 28 Aug 2002 18:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319018AbSH1WGI>; Wed, 28 Aug 2002 18:06:08 -0400
Received: from tapu.f00f.org ([66.60.186.129]:31168 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S319015AbSH1WFO>;
	Wed, 28 Aug 2002 18:05:14 -0400
Date: Wed, 28 Aug 2002 15:09:35 -0700
From: Chris Wedgwood <cw@f00f.org>
To: "David S. Miller" <davem@redhat.com>
Cc: spotter@cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: Re: tcp_hashinfo exported or not?
Message-ID: <20020828220935.GA12963@tapu.f00f.org>
References: <1030503622.487.2.camel@zaphod> <20020827.204259.44983328.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020827.204259.44983328.davem@redhat.com>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 08:42:59PM -0700, David S. Miller wrote:

    It's only exported when IPV6 is enabled as a module.

Conditionally exporting symbols based upon CONFIG_* is a PITA.  Do we
really need to do this and will you accept a patch making go away?

It's nice to be able to build a module outside of the kernel source
and not have to rebuild the kernel to get access to symbols.



  --cw
