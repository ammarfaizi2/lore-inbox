Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317117AbSH0Usk>; Tue, 27 Aug 2002 16:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317112AbSH0Usk>; Tue, 27 Aug 2002 16:48:40 -0400
Received: from tapu.f00f.org ([66.60.186.129]:13751 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S317117AbSH0Usi>;
	Tue, 27 Aug 2002 16:48:38 -0400
Date: Tue, 27 Aug 2002 13:52:58 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Zheng Jian-Ming <zjm@cis.nctu.edu.tw>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problems with changing UID/GID
Message-ID: <20020827205258.GA9199@tapu.f00f.org>
References: <20020827200025.GA8985@tapu.f00f.org> <Pine.LNX.4.44.0208271420190.3234-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208271420190.3234-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 02:25:08PM -0600, Thunder from the hill wrote:

    > Almost immeasurable.  [sg]et[eu]id doesn't get called that
    > often.

    Syscalls do.

And they will almost never have to wait, perhaps spin for a few cycles
in the case of lock contention.  The only time a syscall will wait for
extended periods of time will be setuid and friends.



  --cw
