Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314841AbSEUPtX>; Tue, 21 May 2002 11:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314889AbSEUPtW>; Tue, 21 May 2002 11:49:22 -0400
Received: from exchange.macrolink.com ([64.173.88.99]:53514 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S314841AbSEUPtV>; Tue, 21 May 2002 11:49:21 -0400
Message-ID: <11E89240C407D311958800A0C9ACF7D13A7832@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Anton Altaparmakov'" <aia21@cantab.net>
Cc: ivangurdiev@linuxfreemail.com, LKML <linux-kernel@vger.kernel.org>
Subject: RE: Compiler question....
Date: Tue, 21 May 2002 08:49:21 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2002, Anton Altaparmakov wrote:
> 
> The error messages the compiler is generating are completely 
> bogus because the unnamed fields ARE of type struct or union. 
> It's just that they are typedeffed so that the words "struct" 
> and "union" do not appear. IMO that is a screwup by gcc...

Agreed, IIRC, didn't ANSI C spec address this specific point? That any two
types which contain matching simple types must be considered to match,
regardless of how they were declared, typedef or explicitly. e.g. Unlike
Pascal, typedef does not create "new" types. It creates aggregates of simple
types. 

Ed

---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
