Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315462AbSEBV7M>; Thu, 2 May 2002 17:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315463AbSEBV7L>; Thu, 2 May 2002 17:59:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57361 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315462AbSEBV7J>;
	Thu, 2 May 2002 17:59:09 -0400
Message-ID: <3CD1B675.BBFBA61B@zip.com.au>
Date: Thu, 02 May 2002 14:58:13 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: daniel@rimspace.net, linux-kernel@vger.kernel.org
Subject: Re: 2.5.12 severe ext3 filesystem corruption warning!
In-Reply-To: <UTC200205022140.g42Le8N14139.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> 
> >> 2.5.12, serious ext3 filesystem corrupting behavior
> 
> I have had problems with 2.5.10 (first few blocks of the root
> filesystem overwritten) and then went back to 2.5.8 that I had
> used for a while already, but then also noticed corruption there.
> Back at 2.4.17 today..
> 
> In my case the problem was almost certainly the IDE code.

hmm.  Maybe.  As Al says, the fact that it concerned
mapped files is deeply fishy.

Daniel, could you please check your logs for IDE
errors and "buffer layer errors" and also tell us
(as much as you can remember) the names of all the
affected files, and what application would have
written them.

Thanks.

-
