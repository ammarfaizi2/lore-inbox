Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292820AbSBVG4T>; Fri, 22 Feb 2002 01:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292821AbSBVG4J>; Fri, 22 Feb 2002 01:56:09 -0500
Received: from relay1.pair.com ([209.68.1.20]:37138 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S292820AbSBVGzw>;
	Fri, 22 Feb 2002 01:55:52 -0500
X-pair-Authenticated: 24.126.75.99
Message-ID: <3C75ED64.28CCFA6B@kegel.com>
Date: Thu, 21 Feb 2002 23:04:04 -0800
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org, zab@zabbo.net
Subject: Re: is CONFIG_PACKET_MMAP always a win?
In-Reply-To: <3C75A418.2C848B3F@kegel.com> <20020221.215925.41634293.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> ...
> If not, get a newer copy of the libpcap sources, preferably
> from Alexey's site:
> 
> ftp.inr.ac.ru:/ip-routing/

The important files are a bit buried.  The important ones seem to be

ftp://ftp.inr.ac.ru/ip-routing/lbl-tools/README
ftp://ftp.inr.ac.ru/ip-routing/lbl-tools/libpcap-0.4-ss991029.dif.gz
ftp://ftp.inr.ac.ru/ip-routing/lbl-tools/libpcap-0.4.tar.gz

The .dif file contains the first example I've seen of
how to use socket option PACKET_RX_RING.

- Dan
