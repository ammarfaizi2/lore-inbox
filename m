Return-Path: <linux-kernel-owner+ralf=40uni-koblenz.de@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S317875AbSFNC4K>; Thu, 13 Jun 2002 22:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S317876AbSFNC4J>; Thu, 13 Jun 2002 22:56:09 -0400
Received: from bb-203-125-81-58.singnet.com.sg ([203.125.81.58]:1790 "EHLO fabrice.celestix.com") by vger.kernel.org with ESMTP id <S317875AbSFNC4I>; Thu, 13 Jun 2002 22:56:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Fabrice MARIE <fabrice@celestix.com>
Reply-To: fabrice@celestix.com
Organization: Celestix Networks
To: "Shipman, Jeffrey E" <jeshipm@sandia.gov>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: TCP checksum?
Date: Fri, 14 Jun 2002 11:51:14 +0800
X-Mailer: KMail [version 1.4]
References: <03781128C7B74B4DBC27C55859C9D73809840636@es06snlnt>
In-Reply-To: <03781128C7B74B4DBC27C55859C9D73809840636@es06snlnt>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206141151.14032.fabrice@celestix.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Jeffrey,

On Thursday 13 June 2002 23:10, Shipman, Jeffrey E wrote:
> I'm looking for a function similar to skb_checksum(), but
> for the tcphdr->check field. I'm playing around with a module
> I've written for netfilter and I would like to modify options of
> the IP and TCP headers. For example, right now I'm trying
> to set the destination IP to the source IP, but the TCP checksum
> is coming out incorrectly. How can I calculate this checksum?
> [...]

This functionallity is already provided by the ipt_MIRROR target.

If you want more info on netfilter module writting, read Rusty's
Netfilter Hacking HOWTO at :
http://www.netfilter.org/documentation/index.html#HOWTO
and if needed, post netfilter development questions on the
netfilter-devel mailing list, for more info :
http://www.netfilter.org/contact.html#devlist

Have a nice day,

Fabrice.
--
Fabrice MARIE
Senior R&D Engineer
Celestix Networks
http://www.celestix.com/

"Silly hacker, root is for administrators"
       -Unknown
