Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261627AbSJUU1f>; Mon, 21 Oct 2002 16:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261630AbSJUU1f>; Mon, 21 Oct 2002 16:27:35 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:36037 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261627AbSJUU1e>; Mon, 21 Oct 2002 16:27:34 -0400
Subject: Re: Stress testing cifs filesystem
From: Paul Larson <plars@austin.ibm.com>
To: Steven French <sfrench@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <OF9459582D.95D99040-ON87256C59.005AD875@boulder.ibm.com>
References: <OF9459582D.95D99040-ON87256C59.005AD875@boulder.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 21 Oct 2002 15:25:27 -0500
Message-Id: <1035231927.998.386.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-21 at 11:38, Steven French wrote:
> After struggling with setting up LSB to test
> remote mounts for a while, I checked
> with the LSB team on Andi's suggestion below of
> using the POSIX file API section of LSB on a
> network mount.   They indicated that it won't
> work without modifications to the LSB source,
> (I had been trying to do it via just changing
> the config files) something I will eventually
> have to look into.
Have you tried LTP? We have several fs stress type tests in LTP and with
the (somewhat) new changes to the scripts, it's easier to specify where
the tests create their temporary directories:
'runalltests -d /mnt/cifstest'

Thanks,
Paul Larson

