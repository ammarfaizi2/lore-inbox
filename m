Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263837AbSKTX5J>; Wed, 20 Nov 2002 18:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263760AbSKTX4m>; Wed, 20 Nov 2002 18:56:42 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:50564 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264665AbSKTXz6>; Wed, 20 Nov 2002 18:55:58 -0500
Subject: Re: Early crc32 initialization
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matt_Domsch@Dell.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, brian@murphy.dk
In-Reply-To: <20BF5713E14D5B48AA289F72BD372D68C1EBC4@AUSXMPC122.aus.amer.dell.com>
References: <20BF5713E14D5B48AA289F72BD372D68C1EBC4@AUSXMPC122.aus.amer.dell.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Nov 2002 00:31:34 +0000
Message-Id: <1037838694.3267.111.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-20 at 23:01, Matt_Domsch@Dell.com wrote:
> I have removed dynamic allocation of memory because the 
> memory subsystem is also not initialised at the stage where I
> need the crc functions.

How about generating the table at compile time ?

