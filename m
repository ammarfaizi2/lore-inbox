Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264981AbSJWN3Q>; Wed, 23 Oct 2002 09:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264985AbSJWN3Q>; Wed, 23 Oct 2002 09:29:16 -0400
Received: from 213-187-164-2.dd.nextgentel.com ([213.187.164.2]:62358 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S264981AbSJWN3P> convert rfc822-to-8bit;
	Wed, 23 Oct 2002 09:29:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: "David S. Miller" <davem@rth.ninka.net>, bert hubert <ahu@ds9a.nl>
Subject: Re: [RESEND] tuning linux for high network performance?
Date: Wed, 23 Oct 2002 15:42:48 +0200
User-Agent: KMail/1.4.1
Cc: netdev@oss.sgi.com, Kernel mailing list <linux-kernel@vger.kernel.org>
References: <200210231218.18733.roy@karlsbakk.net> <20021023130101.GA646@outpost.ds9a.nl> <1035379308.5950.3.camel@rth.ninka.net>
In-Reply-To: <1035379308.5950.3.camel@rth.ninka.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210231542.48673.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The e1000 can very well do hardware checksumming on transmit.
>
> The missing piece of the puzzle is that his application is not
> using sendfile(), without which no transmit checksum offload
> can take place.

As far as I've understood, sendfile() won't do much good with large files. Is 
this right?

We're talking of 3-6GB files here ...

roy
-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

