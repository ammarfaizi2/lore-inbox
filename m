Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270478AbRHQTN0>; Fri, 17 Aug 2001 15:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270451AbRHQTNQ>; Fri, 17 Aug 2001 15:13:16 -0400
Received: from wildsau.idv-edu.uni-linz.ac.at ([140.78.40.25]:27399 "EHLO
	wildsau.idv-edu.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id <S270478AbRHQTNI>; Fri, 17 Aug 2001 15:13:08 -0400
From: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>
Message-Id: <200108171913.f7HJDKi00416@wildsau.idv-edu.uni-linz.ac.at>
Subject: min() and max() in kernel.h ?
To: linux-kernel@vger.kernel.org
Date: Fri, 17 Aug 2001 21:13:20 +0200 (MET DST)
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

just now I tried to compile some module and noticed that it doesnt
compile anymore because "macro min used with only two arguments".
I had some "#define min(a,b) (a<b?a:b)" myself.

I then found min() being defined in <linux/kernel.h> with an additional
type argument and some superfluos (imo) assignment code. Erm. What's going
next, drawing elipses in kernel?

I'm also missing some comment who added min/max to kernel.h, at least
I want to know who I am going to flame :->

/herp

