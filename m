Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289344AbSA1Ttp>; Mon, 28 Jan 2002 14:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289341AbSA1TtN>; Mon, 28 Jan 2002 14:49:13 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:11313 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S289372AbSA1Ts2>; Mon, 28 Jan 2002 14:48:28 -0500
To: DervishD <raul@viadomus.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Why 'linux/fs.h' cannot be included? I *can*...
In-Reply-To: <E16VHV3-0001Wh-00@DervishD.viadomus.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Jan 2002 12:44:59 -0700
In-Reply-To: <E16VHV3-0001Wh-00@DervishD.viadomus.com>
Message-ID: <m18zaidzus.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD <raul@viadomus.com> writes:

>     Hello all :))
> 
>     I've reading the source code for 'blockdev', from util-linux, and
> the comments says that the header 'linux/fs.h' cannot be included.
> I've tried, just adding an include and removing the hand made
> definitions (cloning those of fs.h), and all works ok :??
> 
>     This header can be included or not? It works for me, with headers
> from 2.4.17, so, is it just for backwards compatibility?

Policy.  It is for forwards compatibility.  The general policy on kernel
headers is that if it breaks you get to keep the pieces.

Eric
