Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317381AbSFRKrT>; Tue, 18 Jun 2002 06:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317383AbSFRKrS>; Tue, 18 Jun 2002 06:47:18 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:27558 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S317381AbSFRKrS>; Tue, 18 Jun 2002 06:47:18 -0400
Message-ID: <3D0F0F67.3070806@antefacto.com>
Date: Tue, 18 Jun 2002 11:45:59 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dean gaudet <dean-list-linux-kernel@arctic.org>
CC: Andreas Dilger <adilger@clusterfs.com>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: 3x slower file reading oddity
References: <Pine.LNX.4.44.0206171858100.18507-100000@twinlark.arctic.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier's treescan may be of interest:
http://www.tantalophile.demon.co.uk/treescan/
I noticed you're using IDE. Would Jens' TCQ
stuff acheive better parallelism for you?
Does mount -o remount,noatime,nodiratime make
any difference?

Padraig.

