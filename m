Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbTDKCA4 (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 22:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264289AbTDKCA4 (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 22:00:56 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:4518
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264288AbTDKCA4 (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 22:00:56 -0400
Subject: Re: Painlessly shrinking kernel messages (Re: kernel support for
	non-english user messages)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E960536.5010900@techsource.com>
References: <3E95EB6D.4020004@techsource.com>
	 <1050010963.12494.132.camel@dhcp22.swansea.linux.org.uk>
	 <3E960536.5010900@techsource.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050023659.13456.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Apr 2003 02:14:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-04-11 at 00:58, Timothy Miller wrote:
> My google search for '5pack' didn't come up with anything relevant. 
>  Things that come to mind include converting to a character set which 

Its a thing from the old 8bit gaming world.  You code in 5bit chunks
with a leading length marker. 5bits is enough for a-z and some bits
of punctuation, plus capital implying space and 'escape' for an 8bit
sequence block.

Gets you a bit under 40% compression with real life data and takes about
200 bytes to decode


