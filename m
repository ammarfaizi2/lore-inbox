Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271727AbRHQVwd>; Fri, 17 Aug 2001 17:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271725AbRHQVwX>; Fri, 17 Aug 2001 17:52:23 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:6332 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S271727AbRHQVwN>; Fri, 17 Aug 2001 17:52:13 -0400
Date: Fri, 17 Aug 2001 23:52:25 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: linux-kernel@vger.kernel.org
Subject: Re: min() and max() in kernel.h ?
Message-ID: <20010817235225.H9870@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <200108171913.f7HJDKi00416@wildsau.idv-edu.uni-linz.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200108171913.f7HJDKi00416@wildsau.idv-edu.uni-linz.ac.at>; from herp@wildsau.idv-edu.uni-linz.ac.at on Fri, Aug 17, 2001 at 09:13:20PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2001 at 09:13:20PM +0200, Herbert Rosmanith wrote:
> I then found min() being defined in <linux/kernel.h> with an additional
> type argument and some superfluos (imo) assignment code. Erm. What's going
> next, drawing elipses in kernel?
 
The assignment is needed to avoid side effects. Only the
type-argument is discussable. But it is needed due to constants
and sign issues. Details are in the archive.

But I didn't add it, I just understand the reasoning of it an
its implementation.

Regards

Ingo Oeser
-- 
In der Wunschphantasie vieler Mann-Typen [ist die Frau] unsigned und
operatorvertraeglich. --- Dietz Proepper in dasr
