Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262841AbSJONyM>; Tue, 15 Oct 2002 09:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262924AbSJONyM>; Tue, 15 Oct 2002 09:54:12 -0400
Received: from CPE-144-132-192-193.nsw.bigpond.net.au ([144.132.192.193]:30850
	"EHLO anakin.wychk.org") by vger.kernel.org with ESMTP
	id <S262913AbSJONyK>; Tue, 15 Oct 2002 09:54:10 -0400
Date: Tue, 15 Oct 2002 21:53:54 +0800
From: Geoffrey Lee <glee@gnupilgrims.org>
To: Jogchem de Groot <bighawk@kryptology.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: poll() incompatability with POSIX.1-2001
Message-ID: <20021015135354.GA19038@anakin.wychk.org>
References: <20021014145726.DFKF19708.mail8-sh.home.nl@there> <Pine.LNX.3.95.1021014110505.12302A-100000@chaos.analogic.com> <20021015033640.GA15553@anakin.wychk.org> <20021015074616.SQGS394.mail6-sh.home.nl@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Disposition: inline
In-Reply-To: <20021015074616.SQGS394.mail6-sh.home.nl@there>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello, on what version did you try this? I've tried this now on 
> Linux-2.4.18 and Linux-2.4.19 and both give the behaviour i described 
> previously (No POLLOUT set).
> 


Ah, you are indeed right.  I had a typo in my test code (trailing semi
colon).

So POLLIN | POLLERR | POLLHUP flags are for the revents member.



	-- G.

