Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317728AbSFMPfP>; Thu, 13 Jun 2002 11:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317734AbSFMPfO>; Thu, 13 Jun 2002 11:35:14 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:27357 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S317728AbSFMPfN>; Thu, 13 Jun 2002 11:35:13 -0400
Message-ID: <3D08BB90.6010805@antefacto.com>
Date: Thu, 13 Jun 2002 16:34:40 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Shipman, Jeffrey E" <jeshipm@sandia.gov>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: TCP checksum?
In-Reply-To: <03781128C7B74B4DBC27C55859C9D73809840636@es06snlnt>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shipman, Jeffrey E wrote:
> I'm looking for a function similar to skb_checksum(), but
> for the tcphdr->check field. I'm playing around with a module
> I've written for netfilter and I would like to modify options of
> the IP and TCP headers. For example, right now I'm trying
> to set the destination IP to the source IP

I think there already is a module to do this?
Paull Russel (did I get the l's right :-)) mentioned
it at a talk in Ireland a couple of months ago.
There were fun and games when 2 machines with this
module we put back to back and it was noticed that the
ttl wasn't decremented :-P

Padraig.

