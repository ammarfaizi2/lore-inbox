Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289234AbSAXTqi>; Thu, 24 Jan 2002 14:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289581AbSAXTq2>; Thu, 24 Jan 2002 14:46:28 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:60553 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S289234AbSAXTqL>; Thu, 24 Jan 2002 14:46:11 -0500
Date: Thu, 24 Jan 2002 20:46:08 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: booleans and the kernel
Message-ID: <20020124204608.J824@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <3C5047A2.1AB65595@mandrakesoft.com> <a2pn9e$mt5$1@cesium.transmeta.com> <20020124193437.GC23801@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20020124193437.GC23801@conectiva.com.br>; from acme@conectiva.com.br on Thu, Jan 24, 2002 at 05:34:37PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2002 at 05:34:37PM -0200, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jan 24, 2002 at 11:28:46AM -0800, H. Peter Anvin escreveu:
> > Noone is actually meant to use _Bool, except perhaps in header files.
> > 
> > #include <stdbool.h>
>  
> perhaps we don't need another header, adding this instead to types.h.

Since this is compiler specific, what about

#include <linux/compiler.h>

instead? So there would be only one file, the gcc experts
have to track for versions and features.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
     >>>   4. Chemnitzer Linux-Tag - 09.+10. Maerz 2002 <<<
              http://www.tu-chemnitz.de/linux/tag/
