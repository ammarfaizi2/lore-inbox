Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262374AbSJPKTN>; Wed, 16 Oct 2002 06:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262379AbSJPKTM>; Wed, 16 Oct 2002 06:19:12 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:49793 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S262374AbSJPKTM>;
	Wed, 16 Oct 2002 06:19:12 -0400
Date: Wed, 16 Oct 2002 12:25:08 +0200
From: bert hubert <ahu@ds9a.nl>
To: "David S. Miller" <davem@redhat.com>
Cc: matti.aarnio@zmailer.org, zilvinas@gemtek.lt, linux-kernel@vger.kernel.org
Subject: Re: sendfile(2) behaviour has changed ?
Message-ID: <20021016102508.GA7275@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	"David S. Miller" <davem@redhat.com>, matti.aarnio@zmailer.org,
	zilvinas@gemtek.lt, linux-kernel@vger.kernel.org
References: <20021016084908.GA770@gemtek.lt> <20021016091046.GD9644@mea-ext.zmailer.org> <20021016.025935.132073102.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021016.025935.132073102.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 02:59:35AM -0700, David S. Miller wrote:
>      It has only been intended for output to a TCP stream socket.
> 
> To be honest, I'm not so sure about this.

The old manpage did not state this properly. In November 2000 I tried to use
sendfile as recvfile and discovered that it did not work. The ensuing
discussion led to the modification of the manpage to state that it would
only write to a socket and only read from a pagecache backed fd.

Regards,

bert hubert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
