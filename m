Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310582AbSCMNmX>; Wed, 13 Mar 2002 08:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310583AbSCMNmM>; Wed, 13 Mar 2002 08:42:12 -0500
Received: from angband.namesys.com ([212.16.7.85]:14976 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S310582AbSCMNmC>; Wed, 13 Mar 2002 08:42:02 -0500
Date: Wed, 13 Mar 2002 16:41:58 +0300
From: Oleg Drokin <green@namesys.com>
To: Peter Zaitsev <pz@spylog.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MMAP vs READ/WRITE
Message-ID: <20020313164158.A1219@namesys.com>
In-Reply-To: <861732271654.20020313161718@spylog.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <861732271654.20020313161718@spylog.ru>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Mar 13, 2002 at 04:17:18PM +0300, Peter Zaitsev wrote:
>   So I would say mmap is not really optimized nowdays in Linux and so
>   read() may be wining in cases it should not. May be read-ahead is
>   used with read and is not used with mmap.

how about reading manual page on madvise(2) and redoing your test?

Also cache is best cleaned by unmounting filesystem in question
and then mounting it back.

Bye,
    Oleg
