Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267011AbSLWXwi>; Mon, 23 Dec 2002 18:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267013AbSLWXwi>; Mon, 23 Dec 2002 18:52:38 -0500
Received: from tapu.f00f.org ([202.49.232.129]:20620 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S267011AbSLWXwi>;
	Mon, 23 Dec 2002 18:52:38 -0500
Date: Mon, 23 Dec 2002 16:00:48 -0800
From: Chris Wedgwood <cw@f00f.org>
To: "David S. Miller" <davem@redhat.com>
Cc: kiran@in.ibm.com, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] Convert sockets_in_use to use per_cpu areas
Message-ID: <20021224000048.GA14346@tapu.f00f.org>
References: <20021223190847.G23413@in.ibm.com> <20021223.121632.105420794.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021223.121632.105420794.davem@redhat.com>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2002 at 12:16:32PM -0800, David S. Miller wrote:

> You have to provide an explicit initializer for DEFINE_PER_CPU
> declarations or you break some platforms with older GCC's which
> otherwise won't put it into the proper section.

I wonder if "some platforms with older GCC's" will ever have these
issues resolved...


  --cw
