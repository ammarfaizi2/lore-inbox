Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268020AbTAIWHW>; Thu, 9 Jan 2003 17:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268017AbTAIWHW>; Thu, 9 Jan 2003 17:07:22 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:57998
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268016AbTAIWHV>; Thu, 9 Jan 2003 17:07:21 -0500
Subject: Re: [PATCH][TRIVIAL] checksum.h header fixes for 2.4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Eric Weigle <ehw@lanl.gov>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Trivial Patch Monkey <trivial@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030109200646.GG3329@lanl.gov>
References: <20030109200646.GG3329@lanl.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042153307.28469.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 09 Jan 2003 23:01:48 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-09 at 20:06, Eric Weigle wrote:
> I'm making a loadable module that will send IP packets; and need to do IP
> checksums. Unfortunately a simple #include of checksum.h fails because that
> file does not itself include the headers required to compile correctly.
> Several of the arch-specific files are this way.

Include the other files you need first. The kernel headers are not
really intended to always include everything you might want. That
rapidly becomes unmanagable

