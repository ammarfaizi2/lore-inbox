Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316906AbSFKHzk>; Tue, 11 Jun 2002 03:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316909AbSFKHzj>; Tue, 11 Jun 2002 03:55:39 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:18572 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S316906AbSFKHzh>; Tue, 11 Jun 2002 03:55:37 -0400
Date: Tue, 11 Jun 2002 09:54:26 +0200
From: Kristian Peters <kristian.peters@korseby.net>
To: DervishD <raul@pleyades.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bandwidth 'depredation'
Message-Id: <20020611095426.59a8b717.kristian.peters@korseby.net>
In-Reply-To: <3D05AA6E.mailKB1BHA1W@viadomus.com>
X-Mailer: Sylpheed version 0.7.6claws (GTK+ 1.2.10; i386-redhat-linux)
X-Operating-System: i686-redhat-linux 2.4.19-pre10-ac1
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD <raul@pleyades.net> wrote:
>     Hello all :))
>     
>     I've noticed that, when using certain programs like 'wget', the
> bandwidth seems to be 'depredated' by them. When I download a file
> with lukemftp or with links, the bandwidth is then distributed
> between all IP clients, but when using wget or some ftp clients, it
> is not distributed. BTW, I'm using an ADSL line (128 up / 256 down).

Maybe QoS (Quality of Service) is the answer. It does a lot of things for you, i.e. enabling a scheduler for your network, that shares your traffic correctly. But please don't ask me how it exactly works. I haven't enough time yet to get this nice piece working. You need iproute2-utils for this. (They should be shipped with your distri, "which tc" tells you.)

There're several HOWTOs about this topic. A good address is netfilter.kernelnotes.org where you can find the "Advanced Routing HOWTO" or the Unreliable Guides from Rusty.

Hope this helps.

*Kristian

  :... [snd.science] ...:
 ::                             _o)
 :: http://www.korseby.net      /\\
 :: http://gsmp.sf.net         _\_V
  :.........................:
